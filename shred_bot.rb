require 'selenium-webdriver'
require './creds'

"""
OBJECTIVES: 
  1. automate ski resort reservation booking
  2. learn about Selenium & webdrivers
  3. write maintainable and reusable code for others to use
"""

Selenium::WebDriver.logger.level = :debug
Selenium::WebDriver.logger.output = 'selenium.log'
driver = Selenium::WebDriver.for :chrome
wait = Selenium::WebDriver::Wait.new(:timeout => 10)

begin
  # TODO: put chromedriver in better directory than Downloads and add to PATH 
  Selenium::WebDriver::Chrome.driver_path = '/opt/WebDriver/bin/chromedriver'

  driver.manage.new_window(:window)

  # navigate to ikon account page
  driver.get 'https://account.ikonpass.com/en/login'

  # ***** Login Page *****
  email_box = driver.find_element(id: 'email')
  email_box.send_keys(IKON_EMAIL)
  password_box = driver.find_element(id: 'sign-in-password')
  password_box.send_keys(IKON_PW, :return)
  puts "✅ \tlogged in"
  # sleep(2)


  
  # ***** Account Page *****
  # use an explicit wait to avoid 'no such element' error while loading account page
  res_button = wait.until{ driver.find_element(xpath: '//*[@id="root"]/div/div/main/section[1]/div/div[1]/div/a') } # Make a Reservation
  res_button.click
  # sleep(2)



  # ***** Resort Selector Page *****
  resort = 'winter park'
  search_bar = wait.until{ driver.find_element(xpath: '//*[@id="root"]/div/div/main/section[2]/div/div[2]/div[2]/div[1]/div[1]/div/div/div[1]/input') }
  search_bar.send_keys(resort)
  search_bar.send_keys(:arrow_down)
  search_bar.send_keys(:return)
  driver.find_element(xpath: '//*[@id="root"]/div/div/main/section[2]/div/div[2]/div[2]/div[2]/button').click # Continue
  # sleep(2)



  # ***** Date Selector Page *****
  month = 'January'
  day = '22'
  available = false
  sleep(1) # for some reason the explicit wait doesn't work here so use sleep. to be fixed
  # all available dates are of the class DayPicker-Day so iterate through all of them until specified date is found
  day_picker = wait.until{ driver.find_elements(class: 'DayPicker-Day') }
  # puts day_picker.count

  for date in day_picker
    # puts date.text
    if date.text.eql? day
      date.click
      available = true
      break
    end
  end

  if !available
    puts "❌ \tspecified date unavailable, try again later"
    return 
  else
    puts "✅ \tspecified date available"
  end

  # save and continue
  save = wait.until{ driver.find_element(xpath: '//*[@id="root"]/div/div/main/section[2]/div/div[2]/div[3]/div[1]/div[2]/div/div[4]/button[1]') } # Save
  save.click
  continue = wait.until{ driver.find_element(xpath: '//*[@id="root"]/div/div/main/section[2]/div/div[2]/div[3]/div[2]/button') } # Continue to Confirm
  continue.click
  


  # ***** Confirmation Page *****
  driver.find_element(class: 'input').click # click confirmation checkbox
  sleep(1)
  confirm = wait.until{ driver.find_element(xpath: '//*[@id="root"]/div/div/main/section[2]/div/div[2]/div[4]/div/div[5]/button/span') } # Confirm Reservations
  confirm.click
  sleep(1)
  puts "✅ \treservations confirmed!"

  #TODO: some success notification (already get an email from Ikon, maybe I can do a text??)
ensure
  driver.quit
end
