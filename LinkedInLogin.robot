*** Settings ***
Library    Browser
Library    ImageComparisonLibrary.py 
Library    venv/lib/python3.11/site-packages/robot/libraries/OperatingSystem.py

*** Test Cases ***
Detect LinkedIn Home Page Version
    New Browser    browser=Chromium    headless=false    args=["--start-maximized"]
    New Context    viewport=${None}
    New Page    https://www.linkedin.com/
    Take Screenshot    current    # Will be stored in "browser/screenshot/current.png"
    ${best_ssim_match}=    Get Best SSIM Match    browser/screenshot/current.png    linkedin_img/
    IF    '''${best_ssim_match}''' == '''linkedin_img/home_1.png'''
        Login with Professional Community Version
    ELSE IF    '''${best_ssim_match}''' == '''linkedin_img/home_2.png'''
        Login with Community Jobs Version
    ELSE
        Different Case
    END

*** Keywords ***
Get Credentials From Environment
    ${USER}    Get Environment Variable    USER
    ${PASSWORD}    Get Environment Variable    PASSWORD

Login with Professional Community Version
    Type Text    id=session_key    Welcome to your professional community
    Type Text    id=session_password    Welcome to your professional community
    Sleep    5s
    Close Browser
    
Login with Community Jobs Version
    Type Text    id=session_key    Find jobs through your community
    Type Text    id=session_password    Find jobs through your community
    Sleep    5s
    Close Browser

Different Case
    Close Browser