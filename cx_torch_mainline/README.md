# CX Torch Mainline Integration

This directory is the staged integration layer for merging the current
`Sean_WorkDir/libtorch_module` work into `LibtorchSegmentation`.

The first integration version must keep the current cxparser runtime facts as
the source of truth:

- public runtime entry: `cxparser_ext_cxscript_cli`
- public script entry: `--script`
- public dispatch entry: `--kind --layer --module --case`
- result contracts: `UnifiedImageReviewRecord`, `UnifiedTaskReviewBundle`,
  `UnifiedCompareSlice`, `UnifiedAnomalyFocusBundle`
- review outputs: `refs.*`, `elements[]`, `element_chains[]`, and HTML
  observation reports

The merge must be incremental. `LibtorchSegmentation` remains the segmentation
engine base, while the current torch mainline is added as an industrial
multi-model task layer.

Recommended landing order:

1. DeepLab / segmentation adapter
2. ResNet / MobileNet baseline classification adapters
3. MobileViT ROI classification and reclassification adapters
4. YOLOv8 detection adapter
5. YOLO -> ROI crop -> MobileViT attach-back scenario
6. Unified review/report projection

Do not replace the existing cxparser/cxscript runtime semantics with standalone
demo executables. Standalone demos may exist only as local validation helpers.

