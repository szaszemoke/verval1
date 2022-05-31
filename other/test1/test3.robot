*** Settings ***
Library           SeleniumLibrary
Suite Setup       Open the browser
Suite Teardown    Close the browser

*** Variables ***

*** Test Cases ***
Change language to hungarian
    Change language
    Result should be the hungarian page

Go to diploma webpage
    Go to diploma page
    Page should contain deadline of writing the diploma thesis

*** Keywords ***
Open the browser
    Open Browser        https://www.cs.ubbcluj.ro/    browser=chrome
    #Create Webdriver    Chrome    executable_path=D:/a/1/s/node_modules/chromedriver/lib/chromedriver/chromedriver.exe
    Maximize Browser Window    

Close the browser
    Sleep   3s
    Close Browser

Go to the webpage
    Go To       https://www.cs.ubbcluj.ro/

Change language
    Click Element       //*[@id="menu-item-8324-hu"]/a

Result should be the hungarian page
    Element Attribute Value Should Be      //*[@id="header"]/div[1]/a/img       title      Matematika és Informatika Kar


Go to diploma page
    Mouse Over                          //*[@id="menu-item-11458"]/a
    Mouse Over                          //*[@id="menu-item-11461"]
    Wait Until Element Is Visible       //*[@id="menu-item-11461"]/ul
    Click Element                       //*[@id="menu-item-8003"]
    Click Element                          //*[@id="post-7996"]/div/div[2]/div/table/tbody/tr[2]/td[1]/a

Page should contain deadline of writing the diploma thesis
    Element Should Contain          //*[@id="post-51312"]/div[2]/p[5]        9 iunie 2022