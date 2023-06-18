*** Settings ***
Library    authentication.py

*** Variables ***
${CLIENT_ID}      da603d69d8774608b7701a8596b7af29
${CLIENT_SECRET}      8aad743151864eaabd616d0c99f64d10

*** Test Cases ***
Login To Spotify Should Work
    Login To Spotify       ${CLIENT_ID}        ${CLIENT_SECRET}
    ${response}     List Songs From Search      Michael Jackson


#*** Keywords ***
#List Songs From Search
#    [Arguments]    ${query}
#    log to console      xyz
#    log to console      Bad