# Get-SkillList

1. **Datei: `ConvertFrom-YamlLite.ps1`** (Fallback, falls kein `ConvertFrom-Yaml` verfügbar ist)

```powershell
<#
.SYNOPSIS
Parst eine kleine, praxistaugliche YAML-Teilmenge zu einer Hashtable.

.DESCRIPTION
Unterstützt (bewusst minimal):
- key: value
- key: "value" / 'value'
- key: [a, b, c]
- key:
    - item1
    - item2

Gedacht als Fallback für Frontmatter-Metadaten in Markdown-Dateien, wenn kein
ConvertFrom-Yaml Cmdlet verfügbar ist und kein externes YAML-Modul genutzt werden soll.

.PARAMETER Yaml
YAML-Text (ohne --- Marker).

.OUTPUTS
System.Collections.Hashtable
#>
function ConvertFrom-YamlLite {
    [CmdletBinding()]
    [OutputType([hashtable])]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Yaml
    )

    Set-StrictMode -Version Latest

    $Result = @{}
    $CurrentListKey = $null

    $Lines = $Yaml -split "(\r?\n)"
    foreach ($Line in $Lines) {
        if ([string]::IsNullOrWhiteSpace($Line)) {
            continue
        }

        $Trimmed = $Line.Trim()

        if ($Trimmed.StartsWith('#')) {
            continue
        }

        # List entry: "- item"
        if ($Trimmed -match '^-+\s*(.+)$' -and $null -ne $CurrentListKey) {
            $ItemValue = $Matches[1].Trim()

            # Remove quotes if present
            if ($ItemValue -match '^"(.*)"$') { $ItemValue = $Matches[1] }
            elseif ($ItemValue -match "^'(.*)'$") { $ItemValue = $Matches[1] }

            if ($Result.ContainsKey($CurrentListKey) -and ($Result[$CurrentListKey] -is [System.Collections.IList])) {
                [void]$Result[$CurrentListKey].Add($ItemValue)
            }
            else {
                $Result[$CurrentListKey] = [System.Collections.Generic.List[string]]::new()
                [void]$Result[$CurrentListKey].Add($ItemValue)
            }

            continue
        }

        # Key/value: "key: value" or "key:"
        if ($Trimmed -match '^(?<Key>[^:]+)\s*:\s*(?<Value>.*)$') {
            $Key = $Matches['Key'].Trim()
            $ValueRaw = $Matches['Value']

            if ([string]::IsNullOrWhiteSpace($ValueRaw)) {
                # Start list block for this key
                $CurrentListKey = $Key
                if (-not $Result.ContainsKey($Key)) {
                    $Result[$Key] = [System.Collections.Generic.List[string]]::new()
                }
                continue
            }

            $CurrentListKey = $null
            $Value = $ValueRaw.Trim()

            # Inline list: [a, b, c]
            if ($Value -match '^\[(.*)\]$') {
                $Inner = $Matches[1]
                $Parts = $Inner.Split(',') | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne '' }

                $List = @()
                foreach ($Part in $Parts) {
                    $PartValue = $Part
                    if ($PartValue -match '^"(.*)"$') { $PartValue = $Matches[1] }
                    elseif ($PartValue -match "^'(.*)'$") { $PartValue = $Matches[1] }
                    $List += $PartValue
                }

                $Result[$Key] = $List
                continue
            }

            # Quoted string
            if ($Value -match '^"(.*)"$') { $Value = $Matches[1] }
            elseif ($Value -match "^'(.*)'$") { $Value = $Matches[1] }

            $Result[$Key] = $Value
            continue
        }

        # Any other line ends list mode (best effort)
        $CurrentListKey = $null
    }

    # Normalize list values to string[]
    foreach ($Key in @($Result.Keys)) {
        if ($Result[$Key] -is [System.Collections.Generic.List[string]]) {
            $Result[$Key] = @($Result[$Key])
        }
    }

    return $Result
}
```

1. **Datei: `Get-FrontMatterMetadata.ps1`**

```powershell
<#
.SYNOPSIS
Liest YAML-Frontmatter-Metadaten aus einer Markdown-Datei.

.DESCRIPTION
Erkennt Frontmatter am Dateianfang in der Form:

---
name: Example
description: Something
allowed-tools:
  - tool1
  - tool2
---

Gibt eine Hashtable zurück. Wenn keine Frontmatter vorhanden ist, wird eine leere
Hashtable zurückgegeben.

Falls ein Cmdlet ConvertFrom-Yaml vorhanden ist, wird dieses bevorzugt genutzt.
Andernfalls wird ConvertFrom-YamlLite verwendet.

.PARAMETER Path
Pfad zur Markdown-Datei.

.OUTPUTS
System.Collections.Hashtable
#>
function Get-FrontMatterMetadata {
    [CmdletBinding()]
    [OutputType([hashtable])]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({ Test-Path -LiteralPath $_ -PathType Leaf })]
        [string]$Path
    )

    Set-StrictMode -Version Latest

    $Content = Get-Content -LiteralPath $Path -Raw -ErrorAction Stop

    # Match YAML frontmatter at the very start of the file
    $Match = [regex]::Match($Content, '^(?s)---\s*\r?\n(.*?)\r?\n---\s*(?:\r?\n|$)')
    if (-not $Match.Success) {
        return @{}
    }

    $Yaml = $Match.Groups[1].Value
    if ([string]::IsNullOrWhiteSpace($Yaml)) {
        return @{}
    }

    $HasConvertFromYaml = [bool](Get-Command -Name 'ConvertFrom-Yaml' -ErrorAction SilentlyContinue)

    if ($HasConvertFromYaml) {
        try {
            $Parsed = $Yaml | ConvertFrom-Yaml -ErrorAction Stop
            if ($Parsed -is [hashtable]) {
                return $Parsed
            }

            # Convert PSCustomObject to Hashtable (best effort)
            $Meta = @{}
            foreach ($Prop in $Parsed.PSObject.Properties) {
                $Meta[$Prop.Name] = $Prop.Value
            }
            return $Meta
        }
        catch {
            # fall back to lite parser
        }
    }

    return (ConvertFrom-YamlLite -Yaml $Yaml)
}
```

1. **Datei: `Get-CodexSkillList.ps1`**

```powershell
<#
.SYNOPSIS
Sammelt Skill-Metadaten aus SKILL.md Dateien und gibt sie als Objekte zurück.

.DESCRIPTION
Durchsucht ein Skills-Root-Verzeichnis rekursiv nach "SKILL.md".
Für jede Datei wird YAML-Frontmatter gelesen und folgende Felder extrahiert:
- name (string)
- description (string)
- allowed-tools (optional)

Nur Einträge mit name + description als string werden übernommen.
Die Ausgabe ist nach Name sortiert.

.PARAMETER RootPath
Root-Verzeichnis der Skills.
Wenn nicht angegeben: ENV CODEX_SKILLS_DIR, sonst "~/.config/codex/skills".

.OUTPUTS
System.Object[]
#>
function Get-CodexSkillList {
    [CmdletBinding()]
    [OutputType([object[]])]
    param(
        [Parameter()]
        [string]$RootPath
    )

    Set-StrictMode -Version Latest

    $ResolvedRoot =
        if (-not [string]::IsNullOrWhiteSpace($RootPath)) {
            [System.IO.Path]::GetFullPath($RootPath)
        }
        else {
            $EnvRoot = [Environment]::GetEnvironmentVariable('CODEX_SKILLS_DIR')
            if (-not [string]::IsNullOrWhiteSpace($EnvRoot)) {
                [System.IO.Path]::GetFullPath($EnvRoot)
            }
            else {
                $Home = [Environment]::GetFolderPath('UserProfile')
                [System.IO.Path]::GetFullPath((Join-Path -Path $Home -ChildPath '.config/codex/skills'))
            }
        }

    if (-not (Test-Path -LiteralPath $ResolvedRoot -PathType Container)) {
        throw "missing skills dir: $ResolvedRoot"
    }

    $Skills = New-Object System.Collections.Generic.List[object]

    $Files = Get-ChildItem -LiteralPath $ResolvedRoot -Recurse -File -Filter 'SKILL.md' -ErrorAction Stop |
        Sort-Object -Property FullName

    foreach ($File in $Files) {
        $Meta = Get-FrontMatterMetadata -Path $File.FullName
        if ($null -eq $Meta) {
            continue
        }

        $Name = $Meta['name']
        $Description = $Meta['description']

        if (($Name -is [string]) -and ($Description -is [string])) {
            $Item = [ordered]@{
                name        = $Name
                description = $Description
                path        = $File.FullName
            }

            if ($Meta.ContainsKey('allowed-tools')) {
                $Item['allowed-tools'] = $Meta['allowed-tools']
            }

            [void]$Skills.Add([pscustomobject]$Item)
        }
    }

    return @($Skills | Sort-Object -Property name)
}
```

1. **Datei: `Export-CodexSkillsJson.ps1`** (entspricht dem Verhalten deines Python-Skripts: stdout JSON)

```powershell
[CmdletBinding()]
param(
    [Parameter(Position = 0)]
    [string]$RootPath
)

Set-StrictMode -Version Latest

# Dot-source dependencies (anpassen, je nach Ordnerstruktur)
. (Join-Path -Path $PSScriptRoot -ChildPath 'ConvertFrom-YamlLite.ps1')
. (Join-Path -Path $PSScriptRoot -ChildPath 'Get-FrontMatterMetadata.ps1')
. (Join-Path -Path $PSScriptRoot -ChildPath 'Get-CodexSkillList.ps1')

try {
    $Skills = Get-CodexSkillList -RootPath $RootPath
    $Skills | ConvertTo-Json -Depth 20 | Write-Output
}
catch {
    Write-Error -Message $_.Exception.Message
    exit 1
}
```

1. **Ausführen (Beispiele)**

```powershell
# Mit explizitem Root-Ordner
pwsh -File .\Export-CodexSkillsJson.ps1 "C:\Path\To\skills"

# Oder ohne Parameter (nimmt ENV CODEX_SKILLS_DIR oder ~/.config/codex/skills)
pwsh -File .\Export-CodexSkillsJson.ps1
```

1. **Sinnvolle nächste Erweiterungen**

2. Robustere YAML-Unterstützung (verschachtelte Objekte, Typen), optional per Abhängigkeit auf ein YAML-Modul – aber mit sauberer Feature-Detection.

3. Parameter `-AsJson` / `-OutFile` (zusätzlich zu stdout), inkl. UTF-8 Encoding und optional `-NoBOM`.

4. Optionaler Filter `-NameLike`, sowie `-IncludeAllowedTools` Switch, falls du nur bestimmte Metadaten exportieren willst.
