*** Settings ***
Library           SeleniumLibrary
Suite Setup       Open URL Locally

*** Variables ***
${USERNAME1}    felhasznalo
${PASSWORD1}    jelszo
${USERNAME2}    admin
${PASSWORD2}    admin

*** Test Cases ***
Log In A User
    Open Browser To URL
    Log In As User
    Result Should Contain Username
    Close Browser

*** Keywords ***
Open URL Locally
    # Open Webdriver hosted on Azure Devops
    Create Webdriver    Chrome    executable_path=D:/a/1/s/node_modules/chromedriver/lib/chromedriver/chromedriver.exe
    
    # Open Browser on Local Machine
    # Open Browser    https://www.autohero.com/de/search/    chrome
    Maximize Browser Window

Open Browser To URL
    # Open Browser    http://localhost:8080/    browser=chrome
    Go To             https://www.youtube.com/
    # Maximize Browser Window

Log In As User
    Click Element    xpath:/html/body/header/a[2]
    Input Text    //*[@id="main"]/article/form/input[1]    ${USERNAME1}
    Input Password    //*[@id="main"]/article/form/input[2]    ${PASSWORD1}
    Click Element    //*[@id="main"]/article/form/input[3]

Result Should Contain Username
   Element Should Contain    //*[@id="lenyiloListaGomb"]    ${USERNAME1}

    
