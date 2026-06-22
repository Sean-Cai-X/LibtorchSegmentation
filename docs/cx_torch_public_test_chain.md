# CX Torch Public Test Chain

This branch keeps cxparser as the public test authority.

## Required Chain

```text
image / dataset / manifest
  -> cxscript
  -> cxparser_ext_cxscript_cli
  -> UnifiedImageReviewRecord
  -> UnifiedTaskReviewBundle
  -> UnifiedCompareSlice
  -> UnifiedAnomalyFocusBundle
  -> torch host/helper
  -> Unified* result objects
  -> HTML observation gate
```

## Public Runtime

```text
D:\Codex-WorkDir\Sean_WorkDir\cxparser\build\Release\cxparser_ext_cxscript_cli.exe
```

## Canonical Torch Scripts

```text
D:\Codex-WorkDir\Sean_WorkDir\cxparser\rag_script_cases\torch_module\infer\torch_mobilevit_unified_infer.cxsc
D:\Codex-WorkDir\Sean_WorkDir\cxparser\rag_script_cases\torch_module\infer\torch_deeplab_unified_infer.cxsc
D:\Codex-WorkDir\Sean_WorkDir\cxparser\rag_script_cases\torch_module\scenario\torch_yolo_mobilevit_infer_scenario.cxsc
```

## Rules

- `LibtorchSegmentation` may provide model and adapter code.
- `libtorch_module` is the imported baseline for current torch model logic.
- `cx_torch_mainline` is the integration layer between both codebases.
- Functional acceptance still runs through `cxparser_ext_cxscript_cli`.
- Do not promote standalone demos, smoke programs, or local wrappers as public
  test entrypoints.

