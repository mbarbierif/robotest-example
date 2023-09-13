*** Settings ***
Library    SeleniumLibrary    run_on_failure=Log Source
Variables    vars.py

*** Test Cases ***
Foo
    ${prefs}       Create Dictionary
    ${chrome_options} =     Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}    add_experimental_option    prefs    ${prefs}
    ${chrome_options.binary_location}    Set Variable    /Applications/Caret\ Beta.app/Contents/MacOS/Electron
    ${options}=     Call Method     ${chrome_options}    to_capabilities      

    Create Webdriver    Chrome    options=${options}
    Wait Until Page Contains Element    css=.workspace
    [Teardown]    Close All Browsers