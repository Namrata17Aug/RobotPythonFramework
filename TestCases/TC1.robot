*** Settings ***
Library    SeleniumLibrary

*** Test Cases ***
Yahoo Finance Crypto Data Extraction
    Open Browser    https://finance.yahoo.com/    chrome
    Maximize Browser Window
    Mouse Over    xpath=//span[text()='Markets']
    Click Element    xpath=//div[normalize-space(text()) = 'Crypto']/parent::a[@href='https://finance.yahoo.com/markets/crypto/all/']
    Sleep    2s
    FOR    ${ROW_INDEX}    IN RANGE    5
        ${CELL_TEXT}=    Get Text    xpath=(//table/tbody/tr)[${ROW_INDEX}+1]//td[1]/div/span/a/div/span
        Log To Console    ${CELL_TEXT}
    END
    Capture Page Screenshot    my_screenshot.png
    Close Browser