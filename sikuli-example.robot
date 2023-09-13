*** Settings ***
Documentation     Sikuli Working Example
Test Setup        Add Needed Image Path
Test Teardown     Stop Remote Server
Library           SikuliLibrary

*** Variables ***
${IMAGE_DIR}      ${CURDIR}\\img

*** Test Cases ***
Windows Notpad Hello World
    Open Windows Search
    Open Notepad
    Input In Notepad
    Quit Without Save

*** Keywords ***
Add Needed Image Path
    Add Image Path    ${IMAGE_DIR}

Open Windows Search
    Click    windows_search.png

Open Notepad
    Input Text    search_input2.png    notepad
    Click    notepad2.png
    Double Click    notepad_title2.png

Input In Notepad
    Input Text    notepad_workspace2.png    Hello World
    Set Ocr Text Read   true
    ${notepad_text}=   Get Text
    Should Be True  "Hello World" in """${notepad_text}"""

Quit Without Save
    Click    close2.png
    Click    dont_save2.png