#pragma once

#include <string>
#include <vector>

namespace cx_torch_mainline {

struct CxTorchElementRef {
    std::string id;
    std::string kind;
    std::string source_ref;
    std::string status;
};

struct CxTorchChainRef {
    std::string name;
    std::string status;
    std::vector<std::string> element_ids;
};

struct CxTorchUnifiedReviewDraft {
    std::string source_thread;
    std::string case_name;
    std::string image_id;
    std::string input_image_ref;
    std::string primary_visual_ref;
    std::vector<std::string> visualization_refs;
    std::vector<CxTorchElementRef> elements;
    std::vector<CxTorchChainRef> element_chains;
};

}  // namespace cx_torch_mainline

