import os
import cv2
from image_similarity_measures.quality_metrics import rmse, ssim, sre


def get_best_ssim(test_image_path: str, image_dir: str) -> float:
    '''
    Evaluates SSIM (Structural similarity) between a given test image and all the images in a directory.
    Parameters:
    - test_image_path (str): Path to the test image.
    - image_dir (str): Path to the images directory.
    '''
    test_image = cv2.imread(test_image_path)
    scale_percent = 100
    width = int(test_image.shape[1] * scale_percent / 100)
    height = int(test_image.shape[0] * scale_percent / 100)
    dim = (width, height)

    images = [{'path': os.path.join(image_dir, name)} for name in sorted(os.listdir(image_dir)) if os.path.join(image_dir, name)!=test_image_path and '.png' in os.path.join(image_dir, name)]

    for image in images:
        data_image = cv2.imread(image['path'])
        resized_image = cv2.resize(data_image, dim, interpolation = cv2.INTER_AREA)
        image['SSIM'] = ssim(test_image, resized_image)
        print(image)

    best_ssim = max([image['SSIM'] for image in images])

    for image in images:
        if image['SSIM'] == best_ssim:
            print(f'Best Match: {image}\n')
            return image['SSIM']
        

def get_best_rmse(test_image_path: str, image_dir: str) -> float:
    '''
    Evaluates RMSE (Root-Mean-Squared Error) between a given test image and all the images in a directory.
    Parameters:
    - test_image_path (str): Path to the test image.
    - image_dir (str): Path to the images directory.
    '''
    test_image = cv2.imread(test_image_path)
    scale_percent = 100
    width = int(test_image.shape[1] * scale_percent / 100)
    height = int(test_image.shape[0] * scale_percent / 100)
    dim = (width, height)

    images = [{'path': os.path.join(image_dir, name)} for name in sorted(os.listdir(image_dir)) if os.path.join(image_dir, name)!=test_image_path and '.png' in os.path.join(image_dir, name)]

    for image in images:
        data_image = cv2.imread(image['path'])
        resized_image = cv2.resize(data_image, dim, interpolation = cv2.INTER_AREA)
        image['RMSE'] = rmse(test_image, resized_image)
        print(image)

    best_rmse = min([image['RMSE'] for image in images])

    for image in images:
        if image['RMSE'] == best_rmse:
            print(f'Best Match: {image}\n')
            return image['RMSE']
        

def get_best_sre(test_image_path: str, image_dir: str) -> float:
    '''
    Evaluates SRE (Signal to Reconstruction Error Ratio) between a given test image and all the images in a directory.
    Parameters:
    - test_image_path (str): Path to the test image.
    - image_dir (str): Path to the images directory.
    '''
    test_image = cv2.imread(test_image_path)
    scale_percent = 100
    width = int(test_image.shape[1] * scale_percent / 100)
    height = int(test_image.shape[0] * scale_percent / 100)
    dim = (width, height)

    images = [{'path': os.path.join(image_dir, name)} for name in sorted(os.listdir(image_dir)) if os.path.join(image_dir, name)!=test_image_path and '.png' in os.path.join(image_dir, name)]

    for image in images:
        data_image = cv2.imread(image['path'])
        resized_image = cv2.resize(data_image, dim, interpolation = cv2.INTER_AREA)
        image['SRE'] = sre(test_image, resized_image)
        print(image)

    best_sre = max([image['SRE'] for image in images])

    for image in images:
        if image['SRE'] == best_sre:
            print(f'Best Match: {image}\n')
            return image['SRE']
        

def get_best_ssim_match(test_image_path: str, image_dir: str) -> str:
    '''
    Evaluates SSIM (Structural similarity) between a given test image and all the images in a directory, returns the path of the best match.
    Parameters:
    - test_image_path (str): Path to the test image.
    - image_dir (str): Path to the images directory.
    '''
    test_image = cv2.imread(test_image_path)
    scale_percent = 100
    width = int(test_image.shape[1] * scale_percent / 100)
    height = int(test_image.shape[0] * scale_percent / 100)
    dim = (width, height)

    images = [{'path': os.path.join(image_dir, name)} for name in sorted(os.listdir(image_dir)) if os.path.join(image_dir, name)!=test_image_path and '.png' in os.path.join(image_dir, name)]

    for image in images:
        data_image = cv2.imread(image['path'])
        resized_image = cv2.resize(data_image, dim, interpolation = cv2.INTER_AREA)
        image['SSIM'] = ssim(test_image, resized_image)
        print(image)

    best_ssim = max([image['SSIM'] for image in images])

    for image in images:
        if image['SSIM'] == best_ssim:
            print(f'Best Match: {image}\n')
            if image['SSIM'] == 1.0:
                return image['path']
            else:
                return "No match found."
        
if __name__ == '__main__':
    # get_best_ssim("img_100/test-login-0.png", "img_100/")
    # get_best_ssim("img_85/test-login-0.png", "img_85/")
    # get_best_ssim("img_none/test-login-0.png", "img_none/")
    # get_best_rmse("img_100/test-login-0.png", "img_100/")
    # get_best_rmse("img_85/test-login-0.png", "img_85/")
    # get_best_rmse("img_none/test-login-0.png", "img_none/")
    # get_best_sre("img_100/test-login-0.png", "img_100/")
    # get_best_sre("img_85/test-login-0.png", "img_85/")
    # get_best_sre("img_none/test-login-0.png", "img_none/")
    get_best_ssim_match("browser/screenshot/current.png", "linkedin_img/")

