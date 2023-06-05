*** Settings ***
Library    RequestsLibrary
Library    kurs_zlota.py
*** Keywords ***
*** Test Cases ***
A
   ${response}   GET    http://api.nbp.pl/api/cenyzlota/
    log to console    ${response.json()[0]["cena"]}

Lack of Data When Correct Dates Are Given, Error 404 Should Happen
    [Tags]  Negative
    ${response}   GET    http://api.nbp.pl/api/cenyzlota/2003-01-02/2003-01-20  expected_status=404
    should contain     ${response.text}        brak danych      ignore_case=True

Structure Of Table C Should Be As Expected
    ${response}   GET      http://api.nbp.pl/api/exchangerates/rates/c/usd/last/10
    ${pretty}   Pretty Json     ${response.json()}
    log to console    ${pretty}
    #Should Be Equal As Numbers  ${response.json()["rates"][0]["ask"]}   4.4342 #Wyłączone, działa tylko określonego dnia

Table Should Be C and Code USD also length should be 10
    ${response}   GET      http://api.nbp.pl/api/exchangerates/rates/c/usd/last/10
    ${pretty}   Pretty Json     ${response.json()}
    Should Be Equal      ${response.json()["table"]}     C     ignore_case=True
    Should Be Equal      ${response.json()["code"]}      USD
    length should be     ${response.json()["rates"]}     10

*** Variables ***
