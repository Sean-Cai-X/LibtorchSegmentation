$ErrorActionPreference = "Stop"

$repo = Split-Path -Parent $PSScriptRoot
$checks = @()

function Add-Check {
    param(
        [string]$Name,
        [bool]$Passed,
        [string]$Detail
    )
    $script:checks += [pscustomobject]@{
        name = $Name
        passed = $Passed
        detail = $Detail
    }
}

function Read-Text {
    param([string]$Path)
    return [System.IO.File]::ReadAllText($Path)
}

$rootCmake = Join-Path $repo "CMakeLists.txt"
$publicRuntime = "D:\Codex-WorkDir\Sean_WorkDir\cxparser\build\Release\cxparser_ext_cxscript_cli.exe"
$publicTestChainDoc = Join-Path $repo "docs\cx_torch_public_test_chain.md"
$mainlineCmake = Join-Path $repo "cx_torch_mainline\CMakeLists.txt"
$baselineCmake = Join-Path $repo "libtorch_module\CMakeLists.txt"
$contractHeader = Join-Path $repo "cx_torch_mainline\contracts\cxparser_contract.h"
$deeplabAdapter = Join-Path $repo "cx_torch_mainline\adapters\deeplab_segmentation_adapter.h"
$bridgeHeader = Join-Path $repo "cx_torch_mainline\bridge\cx_torch_result_bridge.h"

Add-Check "root_cmake_exists" (Test-Path -LiteralPath $rootCmake) $rootCmake
Add-Check "mainline_cmake_exists" (Test-Path -LiteralPath $mainlineCmake) $mainlineCmake
Add-Check "baseline_cmake_exists" (Test-Path -LiteralPath $baselineCmake) $baselineCmake
Add-Check "contract_header_exists" (Test-Path -LiteralPath $contractHeader) $contractHeader
Add-Check "deeplab_adapter_exists" (Test-Path -LiteralPath $deeplabAdapter) $deeplabAdapter
Add-Check "bridge_header_exists" (Test-Path -LiteralPath $bridgeHeader) $bridgeHeader
Add-Check "public_test_chain_doc_exists" (Test-Path -LiteralPath $publicTestChainDoc) $publicTestChainDoc

$rootText = Read-Text $rootCmake
$mainlineText = Read-Text $mainlineCmake
$baselineText = Read-Text $baselineCmake
$contractText = Read-Text $contractHeader
$adapterText = Read-Text $deeplabAdapter
$bridgeText = Read-Text $bridgeHeader
$publicTestChainText = Read-Text $publicTestChainDoc

Add-Check "cxparser_public_entry_preserved" ($contractText.Contains("cxparser_ext_cxscript_cli")) "public entry remains explicit"
Add-Check "script_invocation_preserved" ($contractText.Contains("--script") -and $contractText.Contains("--kind --layer --module --case")) "public invocation shapes are explicit"
Add-Check "public_runtime_path_documented" ($publicTestChainText.Contains($publicRuntime)) $publicRuntime
Add-Check "public_chain_documented" ($publicTestChainText.Contains("image / dataset / manifest") -and $publicTestChainText.Contains("HTML observation gate")) "cxparser-to-HTML chain is explicit"
Add-Check "unified_records_preserved" ($contractText.Contains("UnifiedImageReviewRecord") -and $contractText.Contains("UnifiedTaskReviewBundle")) "Unified* records are present"
Add-Check "element_chains_preserved" ($contractText.Contains("bbox") -and $contractText.Contains("roi_crop") -and $contractText.Contains("template_alignment") -and $contractText.Contains("roi_diff")) "required chains are present"
Add-Check "mainline_option_default_off" ($rootText.Contains('option(CX_TORCH_MAINLINE_ENABLE "Enable the cx torch mainline integration skeleton" OFF)')) "integration remains opt-in"
Add-Check "baseline_target_added" ($baselineText.Contains("cx_libtorch_module_baseline")) "imported libtorch_module has a target"
Add-Check "mainline_links_both_modules" ($mainlineText.Contains("segmentation") -and $mainlineText.Contains("cx_libtorch_module_baseline")) "adapter target links both modules"
Add-Check "deeplab_review_projection" ($adapterText.Contains("BuildDeepLabSegmentationReviewDraft") -and $adapterText.Contains("closed_region") -and $adapterText.Contains("template_alignment")) "DeepLab adapter projects review elements"
Add-Check "explicit_missing_chains" ($adapterText.Contains('"bbox"') -and $adapterText.Contains('"missing"') -and $adapterText.Contains('"roi_crop"')) "non-produced chains are explicit"
Add-Check "placeholder_runtime_not_verified" ($adapterText.Contains("verified_runtime_ms = -1.0")) "verified runtime starts unmeasured"
Add-Check "review_draft_has_elements" ($bridgeText.Contains("elements") -and $bridgeText.Contains("element_chains")) "review draft carries elements and chains"

$failed = @($checks | Where-Object { -not $_.passed })
foreach ($check in $checks) {
    $state = if ($check.passed) { "PASS" } else { "FAIL" }
    Write-Host ("[{0}] {1} - {2}" -f $state, $check.name, $check.detail)
}

if ($failed.Count -gt 0) {
    throw ("Phase1 verification failed: " + ($failed.name -join ", "))
}

Write-Host "PHASE1_VERIFICATION=PASS"
