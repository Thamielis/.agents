powershell
<#
.SYNOPSIS
Runs smoke checks and (optionally) Pester tests for a Pode tool project.

.DESCRIPTION
- Validates that core scripts parse.
- Runs Pester if available.
- Produces a summarized result object.

.PARAMETER Path
Project root path (defaults to current directory).

.EXAMPLE
Invoke-PodeToolSelfTest
Invoke-PodeToolSelfTest -Path C:\repo\MyTool

.OUTPUTS
System.Management.Automation.PSCustomObject
#>
function Invoke-PodeToolSelfTest {
    [CmdletBinding()]
    param(
        [Parameter()]
        [string]$Path = (Get-Location).Path
    )

    $ProjectRoot = (Resolve-Path -Path $Path).Path

    $Results = [ordered]@{
        ProjectRoot = $ProjectRoot
        ParseOk     = $true
        PesterRan   = $false
        PesterOk    = $null
        Messages    = @()
    }

    $FilesToParse = @(
        (Join-Path $ProjectRoot 'src\\Server.ps1')
    ) | Where-Object { Test-Path -Path $_ }

    foreach ($File in $FilesToParse) {
        try {
            $null = [System.Management.Automation.Language.Parser]::ParseFile($File, [ref]$null, [ref]$null)
        }
        catch {
            $Results.ParseOk = $false
            $Results.Messages += "Parse failed: $File :: $($_.Exception.Message)"
        }
    }

    $Pester = Get-Module -ListAvailable -Name 'Pester' | Sort-Object Version -Descending | Select-Object -First 1
    if ($Pester -and (Test-Path -Path (Join-Path $ProjectRoot 'tests'))) {
        try {
            Import-Module Pester -ErrorAction Stop
            $PesterResult = Invoke-Pester -Path (Join-Path $ProjectRoot 'tests') -PassThru -ErrorAction Stop
            $Results.PesterRan = $true
            $Results.PesterOk = ($PesterResult.FailedCount -eq 0)
        }
        catch {
            $Results.PesterRan = $true
            $Results.PesterOk = $false
            $Results.Messages += "Pester failed: $($_.Exception.Message)"
        }
    }
    else {
        $Results.Messages += "Pester not found or tests folder missing; skipped."
    }

    [PSCustomObject]$Results
}
