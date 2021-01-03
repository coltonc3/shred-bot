require "selenium-webdriver"

driver = Selenium::Webdriver.for :chrome

# TODO: put chromedriver in better directory than Downloads and add to path 
Selenium::WebDriver::Chrome.driver_path = "~/Downloads/chromedriver"

# navigate to ikon account page
driver.navigate.to "https://account.ikonpass.com/en/login?redirect_uri=/en/myaccount"

# login with facebook
fb_button = driver.find_element(class: "fb-sign-in amp-button plain")
#
fb_button.click

res_button = driver.find_element()
