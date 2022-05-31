*** Settings ***
Library           SeleniumLibrary
Suite Setup       Open browser to URL
Suite Teardown    Close the browser
Test Template 	  Registration Should Fail When

*** Variables ***

*** Test Cases ***      Lastname   Firstname    Email               Username     Password1   Password2
Üres név1               ${EMPTY}    Emőke       emoke@gmail.com     emoke        emoke       emoke
Üres név2               Szász    ${EMPTY}       emoke@gmail.com     emoke        emoke       emoke
Üres email              Szász    Emőke           ${EMPTY}           emoke        emoke       emoke
Üres felasználóhnév     Szász    Emőke          emoke@gmail.com     ${EMPTY}     emoke       emoke
Üres jelszó1            Szász    Emőke          emoke@gmail.com     emoke        ${EMPTY}    emoke
Üres jelszó2            Szász    Emőke          emoke@gmail.com     emoke        emoke       ${EMPTY}
Különböző jelszavak     Szász    Emőke          emoke@gmail.com     emoke        emoke       emoke1
Létező felhasználónév   Szász    Emőke          emoke@gmail.com     felhasznalo  emoke       emoke

*** Keywords ***
Open browser to URL
    Open Browser    http://localhost:8080/    browser=chrome
    Maximize Browser Window    

Close the browser
    Close Browser

Registration Should Fail When   [Arguments]  ${lastname}   ${firstname}    ${email}    ${username}   ${password1}  ${password2}
    Click Element           xpath:/html/body/header/a[2]
    Click Element           //*[@id="main"]/article/div/a
    Input Text              //*[@id="main"]/article/form/input[1]    ${lastname}
    Input Text              //*[@id="main"]/article/form/input[2]    ${firstname}
    Input Text              //*[@id="main"]/article/form/input[3]    ${email}
    Input Text              //*[@id="main"]/article/form/input[4]    ${username}
    Input Password          //*[@id="main"]/article/form/input[5]    ${password1}
    Input Password          //*[@id="main"]/article/form/input[6]    ${password2}
    Click Element           //*[@id="main"]/article/form/input[7]
    Element Should Contain  //*[@id="main"]/article/div              Hiba