require 'fileutils'
require 'selenium-webdriver'
require 'watir'



options = Selenium::WebDriver::Chrome::Options.new(args: ['headless'])

driver = Selenium::WebDriver.for(:chrome, options: options)

driver.get('http://stackoverflow.com/')
puts driver.title

driver.quit

#driver = Selenium::WebDriver.for:chrome

#driver.get "https://www.google.com"

#browser = Watir::Browser.new :chrome

#browser.goto('http://stackoverflow.com/')

#puts browser.title

#browser.close


