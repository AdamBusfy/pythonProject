*** Settings ***
Library                                            Selenium2Library
Library                                            String

*** Variables ***
${url}                                                https://www.bistro.sk
${browser}                                            chrome
${filter}                                             name:Filter
${search_input}                                       css:#header > div > div.searchBox.s-hp > bistro-hp-search > div > div.autocomplete-search > div > input[type=text]
${searched_city}                                      Zilina
${accept_cookies}                                     css:#aboutCookieUsageBox > a.close.customClose
${city}                                               css:#header > div > div.searchBox.s-hp > bistro-hp-search > div > div.autocomplete-search > div.location-results.autocomplete-results.location-results--scrollable > div:nth-child(1)
${restaurants_count}                                  css:#header > div.content > div.bistro-header-search-wrapper > bistro-header-search > div > div.bistro-header-search--textual > span.bistro-header-search--textual--restaurants-count

*** Test Cases ***

Number of restaurants check

    Open browser prerequisite

    ${count}=  Get Text  ${restaurants_count}
    ${fetchedString}=  Fetch from right  ${count}  -${space}
    ${fetchedString}=  Fetch from left  ${fetchedString}  ${space}

    ${result}=  Convert To Integer  ${fetchedString}

    ${xpath}=    Set Variable  //div[@id="content"]/div[@class='listItems topPadded']//div[@class='row displayCustomHoverHint delivery_time']/strong
    ${div_counts}=    Get Element Count    ${xpath}

    run keyword if  '${result}'!= '${div_counts}'  Fatal Error  Number of restaurants does not match number of divs. Number of divs => ${div_counts}, Should be ${result}

    close all browsers

*** Keywords ***

Open browser prerequisite
    open browser                                    ${url}    ${browser}
    wait until page contains                        Bistro.sk
    click element                                   ${accept_cookies}
    input text                                      ${search_input}  ${searched_city}
    Wait Until Element Is Visible                   css:#header > div > div.searchBox.s-hp > bistro-hp-search > div > div.autocomplete-search > div.location-results.autocomplete-results.location-results--scrollable
    click element                                   ${city}
    sleep  1s
