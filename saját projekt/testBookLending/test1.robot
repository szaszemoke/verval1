*** Settings ***
Library           SeleniumLibrary
Suite Setup       Open browser to URL
Suite Teardown    Close the browser

*** Variables ***
${USERNAME1}    felhasznalo
${PASSWORD1}    jelszo
${USERNAME2}    admin
${PASSWORD2}    admin
${ISBN1}        1000000000123

${ISBN2}        1234567890
${TITLE}        Narnia krónikái: A végső ütközet
${AUTHOR}       Clive Staples Lewis
${YEAR}         1955
${DESCRIPTION}  Kedves kis könyv. :)
${CATEGORY}     1
${NR}           2
${FILE_PATH}    C:/Users/szasz/Desktop/Ver&val/vizsga/testBookLending/Narnia.jpg

*** Test Cases ***
Lend a book
    Log in ${USERNAME1} ${PASSWORD1}
    Lend book with isbn ${ISBN1}
    Check if has lending with isbn ${ISBN1}
    Log out

Return a book
    Log in ${USERNAME1} ${PASSWORD1}
    Return book with isbn ${ISBN1}
    Check if doesn't have lending
    Log out

Add a book to store
    Log in ${USERNAME2} ${PASSWORD2}
    Add a book
    Check if result contains book with isbn ${ISBN2}
    Log out

Search by title
    Log in ${USERNAME2} ${PASSWORD2}
    Search by title ${TITLE}
    Check if result contains book with isbn ${ISBN2}
    Log out

Remover book from store
    Log in ${USERNAME2} ${PASSWORD2}
    Remove a book
    Check if result not contains book with isbn ${ISBN2}
    Log out

*** Keywords ***
Open browser to URL
    Open Browser    http://localhost:8080/    browser=chrome
    Maximize Browser Window    

Close the browser
    Close Browser

Log in ${username} ${password}
    Click Element       xpath:/html/body/header/a[2]
    Input Text          //*[@id="main"]/article/form/input[1]    ${username}
    Input Password      //*[@id="main"]/article/form/input[2]    ${password}
    Click Element       //*[@id="main"]/article/form/input[3]

Log out
    Click Element       //*[@id="lenyiloListaGomb"]
    Wait Until Element Is Visible       //*[@id="lenyiloListaElem"]
    Click Element       //*[@id="lenyiloListaElem"]/a[4]

Lend book with isbn ${isbn}
    Click Element       xpath:/html/body/header/a[2]
    Mouse Down       //*[@id="isbn"]
    Wait Until Element Is Visible       //*[@id="isbn"]/option
    Select From List By Value       //*[@id="isbn"]     ${isbn}
    Click Element       //*[@id="kuldes"]

Return book with isbn ${isbn}
    Click Element       xpath:/html/body/header/a[3]
    Mouse Down       //*[@id="isbn"]
    Wait Until Element Is Visible       //*[@id="isbn"]/option
    Select From List By Value       //*[@id="isbn"]     ${isbn}
    Click Element       //*[@id="kuldes"]

Check if has lending with isbn ${isbn}
    Click Element       //*[@id="lenyiloListaGomb"]
    Wait Until Element Is Visible       //*[@id="lenyiloListaElem"]
    Click Element       //*[@id="lenyiloListaElem"]/a[1]
    Page Should Contain Element       //*[@id="${isbn}"]

Check if doesn't have lending
    Click Element       //*[@id="lenyiloListaGomb"]
    Wait Until Element Is Visible       //*[@id="lenyiloListaElem"]
    Click Element       //*[@id="lenyiloListaElem"]/a[1]
    Element should Contain      //*[@id="main"]/article/div/p[1]      Ön jelenleg egy könyvet sem kölcsönöz.

Add a book
    Click Element       xpath:/html/body/header/a[4]
    Input Text          //*[@id="isbn"]         ${ISBN2}
    Input Text          //*[@id="cim"]          ${TITLE}
    Input Text          //*[@id="szerzo"]       ${AUTHOR}
    Input Text        //*[@id="kiadasiev"]    ${YEAR}
    Input Text          //*[@id="osszefoglalo"]     ${DESCRIPTION}
    Select From List By Value       //*[@id="kategoria"]     ${CATEGORY}
    Choose File          //*[@id="boritokep"]    ${FILE_PATH}
    Input Text        //*[@id="peldanyszam"]  ${NR}
    Click Element       //*[@id="kuldes"]

Remove a book
    Click Element       //*[@id="${ISBN2}"]/button

Check if result contains book with isbn ${isbn}
    Page Should Contain Element     //*[@id=${isbn}]

Check if result not contains book with isbn ${isbn}
    Page Should Not Contain Element     //*[@id=${isbn}]

Search by title ${booktitle}
    Click Element       xpath:/html/body/header/a[1]
    Input Text          //*[@id="kereses"]      ${booktitle}
    Click Element       //*[@id="kereseskuldes"]