*** Settings ***
Library    RequestsLibrary

*** Test Cases ***
Quick Get All Countries Data
    ${response}=    GET  https://restcountries.com/v3.1/all

Quick Get All Country Names
    ${response}=    GET  https://restcountries.com/v3.1/all    params=fields=name    expected_status=200
