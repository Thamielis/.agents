<#
.SYNOPSIS
Scaffolds a new Podex feature (api + views + htmx + tests) using included templates.

.DESCRIPTION
Creates a feature skeleton aligned with the Podex repo layout:
- api/
- views/
- htmx/
- tests/

It does NOT attempt to auto-wire routes into Podex server startup because projects
vary in how they dot-source or auto-load files. Instead, it outputs exact next steps.

.PARAMETER RootPath
Path to the Podex repository root.

.PARAMETER FeatureName
Human name for the feature (example: "Todo Items").

.PARAMETER FeatureRoute
Route segment used in URLs (example: "Todos"). Defaults to a slug derived from FeatureName.

.PARAMETER FeatureSingular
Singular display name (example: "Todo"). Defaults to first word of FeatureName.

.PARAMETER Force
Overwrite files if they already exist.

.EXAMPLE
New-PodexFeatureScaffold -RootPath . -FeatureName "Todos" -FeatureRoute "Todos" -Force
#>
function New-PodexFeatureScaffold {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$RootPath,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$FeatureName,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]$FeatureRoute,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]$FeatureSingular,

        [Parameter()]
        [switch]$Force
    )

    $RootPath = (Resolve-Path -Path $RootPath).Path

    if (-not $FeatureRoute) {
        $FeatureRoute = ($FeatureName.ToLowerInvariant() -replace '[^a-z0-9]+', '-') -replace '(^-+|-+$)', ''
        if (-not $FeatureRoute) {
            throw "Could not derive FeatureRoute from FeatureName '$FeatureName'. Please specify -FeatureRoute."
        }
    }

    if (-not $FeatureSingular) {
        $FeatureSingular = ($FeatureName -split '\s+')[0]
    }

    $FeatureTitle = $FeatureName

    $ApiPath   = Join-Path -Path $RootPath -ChildPath 'api'
    $ViewsPath = Join-Path -Path $RootPath -ChildPath 'views'
    $HtmxPath  = Join-Path -Path $RootPath -ChildPath 'htmx'
    $TestsPath = Join-Path -Path $RootPath -ChildPath 'tests'

    foreach ($Path in @($ApiPath, $ViewsPath, $HtmxPath, $TestsPath)) {
        if (-not (Test-Path -Path $Path)) {
            throw "Missing expected directory: $Path"
        }
    }

    $SkillRoot = Split-Path -Parent $PSScriptRoot
    $ScaffoldRoot = Join-Path -Path $SkillRoot -ChildPath 'assets/scaffolds'

    $PageTemplate  = Join-Path -Path $ScaffoldRoot -ChildPath 'feature-page.mustache.tmpl'
    $TableTemplate = Join-Path -Path $ScaffoldRoot -ChildPath 'feature-table.mustache.tmpl'
    $FormTemplate  = Join-Path -Path $ScaffoldRoot -ChildPath 'feature-form.mustache.tmpl'

    foreach ($TemplatePath in @($PageTemplate, $TableTemplate, $FormTemplate)) {
        if (-not (Test-Path -Path $TemplatePath)) {
            throw "Missing template file: $TemplatePath"
        }
    }

    $PageOut  = Join-Path -Path $ViewsPath -ChildPath ("{0}.mustache" -f $FeatureRoute.ToLowerInvariant())
    $TableOut = Join-Path -Path $HtmxPath  -ChildPath ("{0}-table.mustache" -f $FeatureRoute.ToLowerInvariant())
    $FormOut  = Join-Path -Path $HtmxPath  -ChildPath ("{0}-form.mustache" -f $FeatureRoute.ToLowerInvariant())
    $ApiOut   = Join-Path -Path $ApiPath   -ChildPath ("{0}.ps1" -f $FeatureRoute.ToLowerInvariant())
    $TestOut  = Join-Path -Path $TestsPath -ChildPath ("{0}.Tests.ps1" -f $FeatureRoute.ToLowerInvariant())

    $TemplateMap = @(
        @{ In = $PageTemplate;  Out = $PageOut  }
        @{ In = $TableTemplate; Out = $TableOut }
        @{ In = $FormTemplate;  Out = $FormOut  }
    )

    foreach ($Item in $TemplateMap) {
        if ((Test-Path -Path $Item.Out) -and (-not $Force)) {
            throw "File exists: $($Item.Out). Use -Force to overwrite."
        }
    }

    if ((Test-Path -Path $ApiOut) -and (-not $Force)) {
        throw "File exists: $ApiOut. Use -Force to overwrite."
    }

    if ((Test-Path -Path $TestOut) -and (-not $Force)) {
        throw "File exists: $TestOut. Use -Force to overwrite."
    }

    $Replacements = @{
        '{{FeatureTitle}}'    = $FeatureTitle
        '{{FeatureRoute}}'    = $FeatureRoute
        '{{FeatureSingular}}' = $FeatureSingular
    }

    foreach ($Item in $TemplateMap) {
        $Content = Get-Content -Path $Item.In -Raw -ErrorAction Stop
        foreach ($Key in $Replacements.Keys) {
            $Content = $Content -replace [regex]::Escape($Key), [System.Text.RegularExpressions.Regex]::Escape($Replacements[$Key]).Replace('\', '\')
        }

        if ($PSCmdlet.ShouldProcess($Item.Out, "Write scaffold file")) {
            $null = New-Item -Path (Split-Path -Parent $Item.Out) -ItemType Directory -Force
            Set-Content -Path $Item.Out -Value $Content -Encoding UTF8
        }
    }

    $ApiContent = @"
<#
.SYNOPSIS
Routes for the '$FeatureTitle' feature.

.DESCRIPTION
Implements:
- GET  /$FeatureRoute
- GET  /$FeatureRoute/Table
- GET  /$FeatureRoute/Form
- POST /$FeatureRoute/Create
- POST /$FeatureRoute/Update
- POST /$FeatureRoute/Delete

NOTE: Wire these routes into your Podex server startup using the repo's existing pattern.
#>

# TODO: add required dot-sources / imports according to Podex conventions.

# Page route (full render)
# Add-PodeRoute -Method Get -Path "/$FeatureRoute" -ScriptBlock {
#     # Render view: views/$($FeatureRoute.ToLowerInvariant()).mustache
# }

# htmx fragments
# Add-PodeRoute -Method Get -Path "/$FeatureRoute/Table" -ScriptBlock { }
# Add-PodeRoute -Method Get -Path "/$FeatureRoute/Form" -ScriptBlock { }

# mutations
# Add-PodeRoute -Method Post -Path "/$FeatureRoute/Create" -ScriptBlock { }
# Add-PodeRoute -Method Post -Path "/$FeatureRoute/Update" -ScriptBlock { }
# Add-PodeRoute -Method Post -Path "/$FeatureRoute/Delete" -ScriptBlock { }
"@

    if ($PSCmdlet.ShouldProcess($ApiOut, "Write api scaffold")) {
        Set-Content -Path $ApiOut -Value $ApiContent -Encoding UTF8
    }

    $TestContent = @"
Describe '$FeatureTitle feature scaffolding' {
    It 'has page + partial templates' {
        Test-Path '$PageOut'  | Should -BeTrue
        Test-Path '$TableOut' | Should -BeTrue
        Test-Path '$FormOut'  | Should -BeTrue
    }

    It 'has an api route stub' {
        Test-Path '$ApiOut' | Should -BeTrue
    }
}
"@

    if ($PSCmdlet.ShouldProcess($TestOut, "Write tests scaffold")) {
        Set-Content -Path $TestOut -Value $TestContent -Encoding UTF8
    }

    [PSCustomObject]@{
        RootPath        = $RootPath
        FeatureName     = $FeatureName
        FeatureRoute    = $FeatureRoute
        FeatureSingular = $FeatureSingular
        FilesCreated    = @($PageOut, $TableOut, $FormOut, $ApiOut, $TestOut)
        NextSteps       = @(
            "1) Wire api/$($FeatureRoute.ToLowerInvariant()).ps1 into your server startup (follow existing Podex pattern).",
            "2) Implement the route bodies (page render + partials + POST handlers).",
            "3) Run Pester for tests/$($FeatureRoute.ToLowerInvariant()).Tests.ps1."
        )
    }
}
