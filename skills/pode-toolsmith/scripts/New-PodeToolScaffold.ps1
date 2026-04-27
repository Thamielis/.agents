powershell
<#
.SYNOPSIS
Creates a structured scaffold for a Pode / Pode.Web / Podex tool project.

.DESCRIPTION
Creates folders and starter files. Idempotent for existing paths (does not overwrite unless -Force).
Designed for Codex-assisted workflows.

.PARAMETER Path
Target directory for the new project.

.PARAMETER Stack
One of: Pode, PodeWeb, Podex

.PARAMETER AppName
Logical application name used in templates.

.PARAMETER Force
Overwrite existing template files.

.EXAMPLE
New-PodeToolScaffold -Path .\MyTool -Stack PodeWeb -AppName 'My Dashboard'

.OUTPUTS
System.IO.DirectoryInfo
#>
function New-PodeToolScaffold {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Path,

        [Parameter(Mandatory)]
        [ValidateSet('Pode', 'PodeWeb', 'Podex')]
        [string]$Stack,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]$AppName = 'PodeTool',

        [Parameter()]
        [switch]$Force
    )

    $RootPath = (Resolve-Path -Path $Path -ErrorAction SilentlyContinue)
    if (-not $RootPath) {
        $null = New-Item -Path $Path -ItemType Directory -Force
        $RootPath = Resolve-Path -Path $Path
    }

    $ProjectRoot = $RootPath.Path

    $Folders = @(
        'src',
        'src\\Routes',
        'src\\Services',
        'src\\Server',
        'scripts',
        'tests'
    )

    if ($Stack -eq 'Podex') {
        $Folders += @('views', 'public', 'htmx', 'api', 'errors')
    }

    foreach ($Folder in $Folders) {
        $Target = Join-Path $ProjectRoot $Folder
        if (-not (Test-Path -Path $Target)) {
            $null = New-Item -Path $Target -ItemType Directory -Force
        }
    }

    $ServerFile = Join-Path $ProjectRoot 'src\\Server.ps1'
    $ReadmeFile = Join-Path $ProjectRoot 'README.md'
    $AppSettingsFile = Join-Path $ProjectRoot 'appsettings.example.json'

    $TemplatesDir = Join-Path $PSScriptRoot '..\\assets\\templates'

    switch ($Stack) {
        'Pode'    { $TemplateFile = Join-Path $TemplatesDir 'PodeApiServer.ps1.mustache' }
        'PodeWeb' { $TemplateFile = Join-Path $TemplatesDir 'PodeWebApp.ps1.mustache' }
        'Podex'   { $TemplateFile = Join-Path $TemplatesDir 'PodeApiServer.ps1.mustache' }
    }

    if ($PSCmdlet.ShouldProcess($ProjectRoot, "Create scaffold for $Stack")) {
        if ((-not (Test-Path -Path $ServerFile)) -or $Force) {
            $Template = Get-Content -Path $TemplateFile -Raw -Encoding UTF8
            $Content = $Template.Replace('{{AppName}}', $AppName).Replace('{{Version}}', '0.1.0')
            Set-Content -Path $ServerFile -Value $Content -Encoding UTF8
        }

        if ((-not (Test-Path -Path $ReadmeFile)) -or $Force) {
            $Template = Get-Content -Path (Join-Path $TemplatesDir 'README.template.md') -Raw -Encoding UTF8
            $Content = $Template.Replace('{{AppName}}', $AppName).Replace('{{Port}}', '8443')
            Set-Content -Path $ReadmeFile -Value $Content -Encoding UTF8
        }

        if ((-not (Test-Path -Path $AppSettingsFile)) -or $Force) {
            $Json = Get-Content -Path (Join-Path $TemplatesDir 'appsettings.example.json') -Raw -Encoding UTF8
            Set-Content -Path $AppSettingsFile -Value $Json -Encoding UTF8
        }
    }

    Get-Item -Path $ProjectRoot
}
