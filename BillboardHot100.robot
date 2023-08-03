*** Settings ***
Library    Browser
Library    String
Suite Setup    New Browser    browser=${BROWSER}    headless=${HEADLESS}
Test Setup    New Context    viewport={'width': 1920, 'height': 1080}
Test Teardown    Close Context
Suite Teardown    Close Browser

*** Variables ***
${BROWSER}    chromium
${HEADLESS}    False

*** Test Cases ***
Check If Taylor Swift is on the Billboard Hot 100
    Given Billboard Hot 100 is open
    Scroll to bottom
    Loop through the ranking and check for "Taylor Swift"

Check If Phoebe Bridgers is on the Billboard Hot 100
    Given Billboard Hot 100 is open
    Scroll to bottom
    Loop through the ranking and check for "Phoebe Bridgers"

Check If Lorde is on the Billboard Hot 100
    Given Billboard Hot 100 is open
    Scroll to bottom
    Loop through the ranking and check for "Lorde"

Check If Billie Eilish is on the Billboard Hot 100
    Given Billboard Hot 100 is open
    Scroll to bottom
    Loop through the ranking and check for "Billie Eilish"

*** Keywords ***
Billboard Hot 100 is open
    Set Browser Timeout    1m 30s
    Set Strict Mode    False
    New Page    https://www.billboard.com/charts/hot-100/

Scroll to bottom
    ${last_link}=    Get Element    xpath=//a[contains(@href, 'vip.wordpress.com')]
    Scroll To Element    ${last_link}

Loop through the ranking and check for "${artist_name}"
    ${rows}=    Get Elements    xpath=//div[@class='o-chart-results-list-row-container']
    FOR    ${row}    IN    @{rows}
        ${h3_elem}=    Get Element    ${row} >> xpath=//ul//li[4]//ul//li[1]//h3
        ${span_elem}=    Get Element    ${row} >> xpath=//ul//li[4]//ul//li[1]//span
        ${song_title}=    Get Text    ${h3_elem}
        ${song_artist}=    Get Text    ${span_elem}
        ${artist_check}=  Evaluate   "${artist_name}" in """${song_artist}"""
        IF    ${artist_check}
            Pass Execution    ${artist_name} is in the Billboard Hot 100 with the song: "${song_title}"
        END
    END
    Fail    ${artist_name} is not on the Billboard Hot 100
