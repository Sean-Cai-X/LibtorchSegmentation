# CX Torch Mainline Integration Plan

Branch: `codex/libtorch_module`

## Ground Rules

The first version is based on current observed facts from the existing
`Sean_WorkDir` torch/cxparser workflow. Preserve cxparser parsing reliability
before moving model code.

Keep these interfaces stable:

- `cxparser_ext_cxscript_cli`
- `--script`
- `--kind --layer --module --case`
- `UnifiedImageReviewRecord`
- `UnifiedTaskReviewBundle`
- `UnifiedCompareSlice`
- `UnifiedAnomalyFocusBundle`
- `refs.*`
- `elements[]`
- `element_chains[]`

## Merge Model

`LibtorchSegmentation` remains the segmentation engine base. The current
`libtorch_module` work is introduced as `cx_torch_mainline`, an industrial image
task layer.

## Phase 0: Skeleton

- Add CMake options without changing default build behavior.
- Add integration directory skeleton.
- Add result bridge and DeepLab adapter placeholder types.
- Do not move YOLO/MobileViT code yet.

## Phase 1: Segmentation First

Map segmentation/DeepLab outputs to:

- `template_alignment_ref`
- `roi_diff_candidate_ref`
- `roi_diff_candidate_count`
- `closed_region`
- `primary_visual_ref`

## Phase 2: Classification and ROI

Add ResNet/MobileNet baseline and MobileViT ROI classification adapters.

## Phase 3: Detection and Scenario

Add YOLOv8 detection and YOLO -> ROI crop -> MobileViT attach-back scenario.

## Phase 4: Review and Reports

Project every task into unified review records and HTML observation reports.

## Non-goals for the first version

- Replacing cxparser runtime semantics.
- Making demo executables the public entry.
- Treating `runtime_ms=0` as verified performance.
- Reworking CUDA/CMake behavior as a way to switch task semantics.

