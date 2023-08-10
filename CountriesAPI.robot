*** Settings ***
Library    RequestsLibrary
Library    DataDriver
Test Template    Country Has 3-Digit Code

*** Test Cases ***
#Quick Get All Countries Data
#    ${response}=    GET  https://restcountries.com/v3.1/all

#Quick Get All Country Names
#    ${response}=    GET  https://restcountries.com/v3.1/all    params=fields=name    expected_status=200

Country Named ${Country} Has 3-Digit Code ${Code}    Default    UserData
    
*** Keywords ***
Country Has 3-Digit Code
    [Arguments]    ${Country}    ${Code}
    ${response}=    GET  https://restcountries.com/v3.1/name/${Country}    params=fields=name,cca3    expected_status=200
    Should Be Equal As Strings    ${response.json()}[0][cca3]    ${Code}