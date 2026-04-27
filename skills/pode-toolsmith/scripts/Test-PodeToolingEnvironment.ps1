powershell
<#
.SYNOPSIS
Validates local environment prerequisites for Pode/Pode.Web/Podex projects.

.DESCRIPTION
Checks PowerShell version and module availability. Optionally checks Node/npm when using Podex.
Returns a structured object and writes a human-readable summary.

.PARAMETER Stack
One of: Pode, PodeWeb, Podex

.PARAMETER MinimumPowerShellVersion
Minimum PowerShell version required (default: 7.2)

.EXAMPLE
Test-PodeToolingEnvironment -Stack PodeWeb

.OUTPUTS
System.Management.Automation.PSCustomObject
#>
function Test-PodeToolingEnvironment {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateSet('Pode', 'PodeWeb', 'Podex')]
        [string]$Stack,

        [Parameter()]
        [Version]$MinimumPowerShellVersion = [Version]'7.2'
    )

    $Results = [ordered]@{
        Stack               = $Stack
        PowerShellVersion   = $PSVersionTable.PSVersion
        PowerShellOk        = $false
        PodeOk              = $false
        PodeWebOk           = $false
        PesterOk            = $false
        NodeOk              = $null
        NpmOk               = $null
        Messages            = @()
    }

    if ($PSVersionTable.PSVersion -ge $MinimumPowerShellVersion) {
        $Results.PowerShellOk = $true
    }
    else {
        $Results.Messages += "PowerShell $MinimumPowerShellVersion+ required. Found $($PSVersionTable.PSVersion)."
    }

    $Pode = Get-Module -ListAvailable -Name 'Pode' | Sort-Object Version -Descending | Select-Object -First 1
    if ($null -ne $Pode) { $Results.PodeOk = $true } else { $Results.Messages += "Module 'Pode' is missing." }

    if ($Stack -in @('PodeWeb', 'Podex')) {
        $PodeWeb = Get-Module -ListAvailable -Name 'Pode.Web' | Sort-Object Version -Descending | Select-Object -First 1
        if ($null -ne $PodeWeb) { $Results.PodeWebOk = $true } else { $Results.Messages += "Module 'Pode.Web' is missing (required for $Stack)." }
    }

    $Pester = Get-Module -ListAvailable -Name 'Pester' | Sort-Object Version -Descending | Select-Object -First 1
    if ($null -ne $Pester) { $Results.PesterOk = $true } else { $Results.Messages += "Module 'Pester' is missing (recommended for self-tests)." }

    if ($Stack -eq 'Podex') {
        $NodeCmd = Get-Command -Name 'node' -ErrorAction SilentlyContinue
        $NpmCmd  = Get-Command -Name 'npm'  -ErrorAction SilentlyContinue
        $Results.NodeOk = [bool]$NodeCmd
        $Results.NpmOk  = [bool]$NpmCmd
        if (-not $Results.NodeOk) { $Results.Messages += "node is missing (required for Tailwind/tooling in Podex)." }
        if (-not $Results.NpmOk)  { $Results.Messages += "npm is missing (required for Tailwind/tooling in Podex)." }
    }

    [PSCustomObject]$Results
}
