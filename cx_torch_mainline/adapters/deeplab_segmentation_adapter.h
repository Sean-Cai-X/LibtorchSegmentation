#pragma once

#include <string>

namespace cx_torch_mainline {

struct DeepLabSegmentationAdapterInput {
    std::string template_image_ref;
    std::string test_image_ref;
    std::string weight_ref;
    std::string requested_device;
};

struct DeepLabSegmentationAdapterOutput {
    std::string template_alignment_ref;
    std::string roi_diff_candidate_ref;
    int roi_diff_candidate_count = 0;
    std::string primary_visual_ref;
    double verified_runtime_ms = -1.0;
};

}  // namespace cx_torch_mainline

