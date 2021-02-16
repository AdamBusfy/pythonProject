*** Settings ***
Library                                            Selenium2Library

*** Variables ***
${url}                                                https://www.bistro.sk
${browser}                                            chrome
${bistro_title}                                       Bistro.sk - donáška, rozvoz jedla
${login_title}                                        Prihlásenie
${accept_cookies}                                     css:#aboutCookieUsageBox > a.close.customClose
${login_options_button}                               id:loginButton
${azet_login}                                         css:#loginBox > div.box__wrapper.box__wrapper--azet > span.box__wrapper--title.box__wrapper--title-azet
${login_input}                                        css:body > div > div.landing-page__step.landing-page__step--login > div.landing-page__step_content.landing-page__step_content--login > form > div:nth-child(1) > div > input
${password_input}                                     css:body > div > div.landing-page__step.landing-page__step--login > div.landing-page__step_content.landing-page__step_content--login > form > div:nth-child(3) > div > input
${login_button}                                       css:body > div > div.landing-page__step.landing-page__step--login > div.landing-page__step_content.landing-page__step_content--login > form > input
${status_login_user}                                  css:#header > div > div.logoBox > div.loginBar.statusLogin

${correct_login_name}                                 testovaciucetZTS
${correct_login_password}                             testovaciehesloZTS
${incorrect_login_name}                               wrongName
${incorrect_login_password}                           wrongPassword

*** Test Cases ***
Valid login test case
    Open browser prerequisite

    input text                                      ${login_input}  ${correct_login_name}
    input text                                      ${password_input}  ${correct_login_password}
    click element                                   ${login_button}
    Switch Window                                   title=${bistro_title}
    wait until page contains element                ${status_login_user}
    Title should be                                 ${bistro_title}
    close browser

Invalid login test case
    Open browser prerequisite

    input text                                      ${login_input}  ${incorrect_login_name}
    input text                                      ${password_input}  ${incorrect_login_password}
    click element                                   ${login_button}
    sleep  1s
    wait until page contains                        Zadané údaje nie sú správne.
    Title should be                                 ${login_title}
    close browser

Missing login name test case
    Open browser prerequisite

    input text                                      ${password_input}  ${correct_login_password}
    click element                                   ${login_button}
    sleep  1s
    wait until page contains                        Zadané údaje nie sú správne.
    Title should be                                 ${login_title}
    close browser

Missing login password test case
    Open browser prerequisite

    input text                                      ${login_input}  ${correct_login_name}
    click element                                   ${login_button}
    sleep  1s
    wait until page contains                        Zadané údaje nie sú správne.
    Title should be                                 ${login_title}
    close browser


*** Keywords ***

Open browser prerequisite
    [Documentation]                                 The user open browser, visit Bistro.sk and click login
    open browser                                    ${url}    ${browser}
    wait until page contains                        Bistro.sk
    click element                                   ${accept_cookies}
    click element                                   ${login_options_button}
    wait until page contains                        Azet prihlásenie
    click Element                                   ${azet_login}  COMMAND
    Switch Window                                   title=${login_title}
    sleep  0.3s