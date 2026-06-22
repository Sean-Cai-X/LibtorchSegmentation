$ErrorActionPreference = "Stop"

$publicRuntime = "D:\Codex-WorkDir\Sean_WorkDir\cxparser\build\Release\cxparser_ext_cxscript_cli.exe"
$scriptRoot = "D:\Codex-WorkDir\Sean_WorkDir\cxparser\rag_script_cases\torch_module"
$scripts = @(
    (Join-Path $scriptRoot "infer\torch_mobilevit_unified_infer.cxsc"),
    (Join-Path $scriptRoot "infer\torch_deeplab_unified_infer.cxsc"),
    (Join-Path $scriptRoot "scenario\torch_yolo_mobilevit_infer_scenario.cxsc")
)

if (-not (Test-Path -LiteralPath $publicRuntime)) {
    throw "Missing canonical public runtime: $publicRuntime"
}

foreach ($script in $scripts) {
    if (-not (Test-Path -LiteralPath $script)) {
        throw "Missing canonical torch script: $script"
    }
}

foreach ($script in $scripts) {
    Write-Host ("[CX_TORCH_PUBLIC_TEST] " + $script)
    & $publicRuntime --script $script
    if ($LASTEXITCODE -ne 0) {
        throw "cxparser public torch script failed: $script"
    }
}

Write-Host "CX_TORCH_PUBLIC_TESTS=PASS"
