#pragma once

#include <string>

namespace cx_torch_mainline {

struct CxTorchWeightSet {
    std::string yolo_weight_ref;
    std::string mobilevit_weight_ref;
    std::string deeplab_weight_ref;
    std::string resnet50_weight_ref;
};

inline CxTorchWeightSet DefaultWeightNames() {
    return CxTorchWeightSet{
        "yolov8n_dict.pt",
        "mobilevitv2_weights.pt",
        "deeplabv3_mobilenet_v3_large-fc3c493d.pth",
        "resnet50_weights.pt",
    };
}

}  // namespace cx_torch_mainline

