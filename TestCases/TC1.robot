*** Settings ***
Library    SeleniumLibrary

*** Test Cases ***
Yahoo Finance Crypto Data Extraction
    Open Browser    https://finance.yahoo.com/    chrome
    Maximize Browser Window
    Mouse Over    xpath=//span[text()='Markets']
    Click Element    xpath=//div[normalize-space(text()) = 'Crypto']/parent::a[@href='https://finance.yahoo.com/markets/crypto/all/']
    Sleep    2s
    click Element  xpath=//span[text()='Top Gainers']/parent::a[@href='/markets/crypto/gainers/']
    Wait Until Element Is Visible    xpath=//table/tbody/tr
    Execute JavaScript    window.scrollTo(0, 1500)
        FOR    ${INDEX}    IN RANGE    5
        ${ROW_NUM}=    Evaluate    ${INDEX} + 1
        ${COL_COUNT}=    Get Element Count    xpath=(//table/tbody/tr)[${ROW_NUM}]/td
        ${ROW_DATA}=    Set Variable    ${EMPTY}
            FOR    ${COL}    IN RANGE    ${COL_COUNT}
                ${COL_NUM}=    Evaluate    ${COL} + 1
                ${CELL_TEXT}=    Get Text    xpath=(//table/tbody/tr)[${ROW_NUM}]/td[${COL_NUM}]
                ${ROW_DATA}=    Catenate    SEPARATOR= |     ${ROW_DATA}    ${CELL_TEXT}
            END
	        Log To Console    ${ROW_DATA}
        END
    Capture Page Screenshot    my_screenshot.png
    Close Browser