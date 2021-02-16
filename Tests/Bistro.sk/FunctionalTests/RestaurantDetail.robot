*** Settings ***
Library                                            Selenium2Library
Library                                            RequestsLibrary
Library                                            Collections
Library                                            String

*** Variables ***
${url}                                                https://www.bistro.sk
${browser}                                            chrome
${filter}                                             name:Filter
${search_input}                                       css:#header > div > div.searchBox.s-hp > bistro-hp-search > div > div.autocomplete-search > div > input[type=text]
${searched_city}                                      Zilina
${accept_cookies}                                     css:#aboutCookieUsageBox > a.close.customClose
${city}                                               css:#header > div > div.searchBox.s-hp > bistro-hp-search > div > div.autocomplete-search > div.location-results.autocomplete-results.location-results--scrollable > div:nth-child(1)
${60_minutes_filter}                                  id:deliveryFilterButton
${id_filterFreeDelivery}                              id:filterFreeDelivery

*** Test Cases ***

60 minutes filter control

    Open browser prerequisite

    click element                                   ${60_minutes_filter}

    ${xpath}=    Set Variable  //div[@id="content"]/div[@class='listItems topPadded']//div[@class='row displayCustomHoverHint delivery_time']/strong

    ${count}=    Get Element Count    ${xpath}
    log to console  \nNumber of controlled items ${count}

    ${minutes}=    Create List
    FOR    ${i}    IN RANGE    1    ${count} + 1
     ${minute}=    Get Text    xpath=(${xpath})[${i}]
     ${fetchedString}=  Fetch from left  ${minute}  ${space}-
     run keyword if  '${fetchedString}'!= '--'  Append To List    ${minutes}   ${fetchedString}
    END

    FOR    ${item}     IN      @{minutes}
    ${result}=  Convert To Integer  ${item}
    run keyword if  '${result}'> '60'  Fatal Error  60 MINUTES FILTER ERROR, should be less than 60 and gets: ${item}
    END

    click element                                   ${60_minutes_filter}

Free delivery control
    click element                                   ${filter}
    wait until page contains                        Platba kartou
    click element                                   ${id_filterFreeDelivery}
    sleep  1s
    ${xpath}=    Set Variable  //div[@id="content"]/div[@class='listItems topPadded']//div[@class='left']//div[2]/strong

    ${count}=    Get Element Count    ${xpath}
    log to console  \nNumber of controlled items ${count}

    ${free_deliveries}=    Create List
    FOR    ${i}    IN RANGE    1    ${count} + 1
    ${free_delivery}=    Get Text    xpath=(${xpath})[${i}]
    Run Keyword If  '${free_delivery}' != '0,00 €' and '${free_delivery}' != 'od 0,00 €'  Fatal Error  Delivery price shoul be 0,00 € and is => ${free_delivery}
#    log to console  ${free_delivery}
    END

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
