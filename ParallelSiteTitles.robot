*** Settings ***
Library    SeleniumLibrary

*** Test Cases ***
Testing Chrome with Python.org
    Open URL with Browser    https://www.python.org/    Chrome    Welcome to Python.org

Testing Firefox with Python.org
    Open URL with Browser    https://www.python.org/    Firefox    Welcome to Python.org

Testing Chrome with Wikipedia
    Open URL with Browser    https://www.wikipedia.org/    Chrome    Wikipedia

Testing Firefox with Wikipedia
    Open URL with Browser    https://www.wikipedia.org/    Firefox    Wikipedia

*** Keywords ***
Open URL with Browser
    [Arguments]    ${URL}    ${Browser}    ${Title}
    Open Browser    ${URL}    ${Browser}
    Sleep    2
    Title Should Be    ${Title}
    [Teardown]    Close Browser

