*** Settings ***
Library                                            Selenium2Library
Library                                            RequestsLibrary

*** Variables ***
${url}                                                https://www.bistro.sk
${browser}                                            chrome
${search_input}                                       css:#header > div > div.searchBox.s-hp > bistro-hp-search > div > div.autocomplete-search > div > input[type=text]
${searched_city}                                      Žilina
${accept_cookies}                                     css:#aboutCookieUsageBox > a.close.customClose
${city}                                               css:#header > div > div.searchBox.s-hp > bistro-hp-search > div > div.autocomplete-search > div.location-results.autocomplete-results.location-results--scrollable > div:nth-child(1)
${filter}                                             name:Filter
${id_filterFreeDelivery}                              id:filterFreeDelivery
${id_filterOnlinePayment}                             id:filterOnlinePayment
${id_filterTakeaway}                                  id:filterTakeaway
${id_filterHomeDelivery}                              id:filterHomeDelivery
${id_filterBistroCarrier}                             id:filterBistroCarrier
${id_filter_20perc_discount}                          id:filtercmp_20-zlava-na-rozne-jedla
${id_eko_cover}                                       id:filtercmp_eko-obaly-filter-do-vysledkov--ikona
${erase_all_filters}                                  css:#content > div.listItems.topPadded > div.filterPanel > div.filterOptions > a

*** Test Cases ***
User fill city in the Search text box and submit
    [Documentation]                                 The user search
    open browser                                    ${url}    ${browser}
    wait until page contains                        Bistro.sk
    click element                                   ${accept_cookies}
    input text                                      ${search_input}  ${searched_city}
    wait until element is visible                   css:#header > div > div.searchBox.s-hp > bistro-hp-search > div > div.autocomplete-search > div.location-results.autocomplete-results.location-results--scrollable
    click element                                   ${city}

User click on filterFreeDelivery
    click element                                   ${filter}
    wait until page contains                        Platba kartou
    Click Unclick Check checkbox                    ${id_filterFreeDelivery}

User click on filterOnlinePayment
    click element                                   ${filter}
    wait until page contains                        Platba kartou
    Click Unclick Check checkbox                    ${id_filterOnlinePayment}

User click on filterTakeaway
    click element                                   ${filter}
    wait until page contains                        Platba kartou
    Click Unclick Check checkbox                    ${id_filterTakeaway}

User click on filterHomeDelivery
    click element                                   ${filter}
    wait until page contains                        Platba kartou
    Click Unclick Check checkbox                    ${id_filterHomeDelivery}

User click on filterBistroCarrier
    click element                                   ${filter}
    wait until page contains                        Platba kartou
    Click Unclick Check checkbox                    ${id_filterBistroCarrier}

User click on filter_20perc_discount
    click element                                   ${filter}
    wait until page contains                        Platba kartou
    Click Unclick Check checkbox                    ${id_filter_20perc_discount}

User click on id_eko_cover
    click element                                   ${filter}
    wait until page contains                        Platba kartou
    Click Unclick Check checkbox                    ${id_eko_cover}

User click on all filter checkboxes and click erase all button
    click element                                   ${filter}
    wait until page contains                        Platba kartou
    Click and Check checkbox                        ${id_filterFreeDelivery}
    Click and Check checkbox                        ${id_filterOnlinePayment}
    Click and Check checkbox                        ${id_filterTakeaway}
    Click and Check checkbox                        ${id_filterHomeDelivery}
    Click and Check checkbox                        ${id_filterBistroCarrier}
    Click and Check checkbox                        ${id_filter_20perc_discount}
    Click and Check checkbox                        ${id_eko_cover}

    click element                                   ${erase_all_filters}

    Checkbox Should Not Be Selected                 ${id_filterFreeDelivery}
    Checkbox Should Not Be Selected                 ${id_filterOnlinePayment}
    Checkbox Should Not Be Selected                 ${id_filterTakeaway}
    Checkbox Should Not Be Selected                 ${id_filterHomeDelivery}
    Checkbox Should Not Be Selected                 ${id_filterBistroCarrier}
    Checkbox Should Not Be Selected                 ${id_filter_20perc_discount}
    Checkbox Should Not Be Selected                 ${id_eko_cover}

    close all browsers

*** Keywords ***

Click Unclick Check checkbox
    [Arguments]     ${id}
    Set Variable    ${id}

    Checkbox Should Not Be Selected                 ${id}
    click element                                   ${id}
    Checkbox Should Be Selected                     ${id}
    click element                                   ${id}
    Checkbox Should Not Be Selected                 ${id}

Click and Check checkbox
    [Arguments]     ${id}
    Set Variable    ${id}

    Checkbox Should Not Be Selected                 ${id}
    click element                                   ${id}
    Checkbox Should Be Selected                     ${id}
