*** Settings ***
Library    SeleniumLibrary
Library    DataDriver
Test Template    Open URL with Browser

*** Test Cases ***
Using ${Browser} To Open ${URL} Should Match ${Title}    Default    UserData

*** Keywords ***
Open URL with Browser
    [Arguments]    ${URL}    ${Browser}    ${Title}
    Open Browser    ${URL}    ${Browser}
    Sleep    2
    Title Should Be    ${Title}
    [Teardown]    Close Browser
