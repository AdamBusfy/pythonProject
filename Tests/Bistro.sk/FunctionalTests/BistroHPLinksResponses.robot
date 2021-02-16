*** Settings ***
Library                                            Selenium2Library
Library                                            RequestsLibrary

*** Variables ***
${url}                                              https://www.bistro.sk
${browser}                                          chrome

${session_name}                                     Visit_Bistro
${FAQ}                                              caste-otazky/
${terms_of_usage}                                   podmienky-pouzivania/
${contact}                                          kontakt/zakaznik/
${mobile_applications}                              mobilne-aplikacie/
${cookies}                                          nastavenia/zasady/
${blog}                                             blog/
${data_export}                                      data-export/
${data_delete}                                      data-delete/
${notifications_settings}                           nastavenia-notifikacii/
${about_project}                                    o-projekte/
${contact_partner}                                  kontakt/partner/

${status_code_200}                                  200

*** Test Cases ***
Session create
    create session  ${session_name}  ${url}

FAQ response test
    check_response  ${FAQ}  ${status_code_200}  Akceptujete platbu kartou?

Terms of usage response test
    check_response  ${terms_of_usage}  ${status_code_200}  Ochrana osobn

Contact response test
    check_response  ${contact}  ${status_code_200}  Kontakt pre

Mobile applications response test
    check_response  ${mobile_applications}  ${status_code_200}  Viac ako 900

Cookies response test
    check_response  ${cookies}  ${status_code_200}  cookie

Blog response test
    check_response  ${blog}  ${status_code_200}  Blog Bistro.sk

Data export response test
    check_response  ${data_export}  ${status_code_200}  Export

Data delete response test
    check_response  ${data_delete}  ${status_code_200}  zadaj telef

Notifications response test
    check_response  ${notifications_settings}  ${status_code_200}  Nastavenia notifik

About project response test
    check_response  ${about_project}  ${status_code_200}  O projekte

Contact for restaurants response test
    check_response  ${contact_partner}  ${status_code_200}  Kontakty pre re

*** Keywords ***
check_response
    [Arguments]     ${api}  ${status_code_to_check}  ${contains}
    Set Variable    ${api}  ${status_code_to_check}  ${contains}

    ${response}=  get on session  ${session_name}  ${api}
    ${response_of_status_code}=  convert to string  ${response.status_code}
    should be equal  ${response_of_status_code}  ${status_code_to_check}
    ${body}=  convert to string  ${response.content}
    should contain  ${body}  ${contains}