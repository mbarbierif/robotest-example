*** Settings ***
Library    ImageComparisonLibrary.py

*** Test Cases ***
Exact match with SSIM
    Compare test image img_100/test-login-0.png with images in img_100/ using SSIM measure

Not a perfect match with SSIM
    Compare test image img_85/test-login-0.png with images in img_85/ using SSIM measure

No match with SSIM
    Compare test image img_none/test-login-0.png with images in img_none/ using SSIM measure

Exact match with RMSE
    Compare test image img_100/test-login-0.png with images in img_100/ using RMSE measure

Not a perfect match with RMSE
    Compare test image img_85/test-login-0.png with images in img_85/ using RMSE measure

No match with RMSE
    Compare test image img_none/test-login-0.png with images in img_none/ using RMSE measure

Exact match with SRE
    Compare test image img_100/test-login-0.png with images in img_100/ using SRE measure

Not a perfect match with SRE
    Compare test image img_85/test-login-0.png with images in img_85/ using SRE measure

No match with SRE
    Compare test image img_none/test-login-0.png with images in img_none/ using SRE measure

*** Keywords ***
Compare test image ${test_image_path} with images in ${images_dir} using SSIM measure
    ${best_ssim}=    Get Best SSIM    ${test_image_path}    ${images_dir}
    IF    $best_ssim == 1.0   
        Pass Execution    It's a perfect match! (100%)
    ELSE IF    $best_ssim > 0.85
        Pass Execution    It's not a perfect match, but close! (>85%)
    ELSE
        Fail    No good matches in the directory. (<85%)
    END

Compare test image ${test_image_path} with images in ${images_dir} using RMSE measure
    ${best_ssim}=    Get Best RMSE    ${test_image_path}    ${images_dir}
    IF    $best_ssim == 0.0   
        Pass Execution    It's a perfect match! (0% Error)
    ELSE IF    $best_ssim < 0.02
        Pass Execution    It's not a perfect match, but close! (<2% Error)
    ELSE
        Fail    No good matches in the directory. (>2% Error)
    END

Compare test image ${test_image_path} with images in ${images_dir} using SRE measure
    ${best_ssim}=    Get Best SRE    ${test_image_path}    ${images_dir}
    IF    $best_ssim > 100.0   
        Pass Execution    It's a perfect match!
    ELSE IF    $best_ssim > 75.0
        Pass Execution    It's not a perfect match, but close!
    ELSE
        Fail    No good matches in the directory.
    END