*** Settings ***
Documentation    Sample - Chrome Options
Metadata         Part of Go Green Test Automation samples - see more on https://testautomation.dev

Library          SeleniumLibrary
Library          BuiltIn

Test Setup       Test Case Setup
Test Teardown    Test Case Teardown

*** Test Cases ***
Test Site Login
    [Tags]    login
    Go To     https://www.saucedemo.com
    Input Text        css=#user-name     standard_user
    Input Password    css=#password      secret_sauce
    Submit Form
    Wait Until Page Contains Element    css=#inventory_container

*** Keywords ***
Test Case Setup
    Create WebDriver With Chrome Options

Create WebDriver With Chrome Options
    ${chrome_options} =    Evaluate    selenium.webdriver.ChromeOptions()
    Call Method    ${chrome_options}    add_argument    --log-level\=3
    Call Method    ${chrome_options}    add_argument    --start-maximized
    Call Method    ${chrome_options}    add_argument    --window-size\=800,600
    Call Method    ${chrome_options}    add_argument    --headless
    Call Method    ${chrome_options}    add_argument    --disable-extensions
    Call Method    ${chrome_options}    add_experimental_option    name=w3c    value=${True}
    @{service_args} =    Create List    --log-path=results/chromedriver.log
    Create WebDriver    Chrome    chrome_options=${chrome_options}    service_args=@{service_args}

Test Case Teardown
    Capture Page Screenshot
    Close Browser