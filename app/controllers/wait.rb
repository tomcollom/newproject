require 'selenium-webdriver'
require 'watir'
require 'nokogiri'






options = Selenium::WebDriver::Chrome::Options.new(args: ['headless'])
driver = Selenium::WebDriver.for(:chrome, options: options)

driver.get('https://www.timeanddate.com/weather/uk/london/historic')

puts driver.title

#selectbox = driver.find_element(:id, 'wt-his-select')
#option = Selenium::WebDriver::Support::Select.new(selectbox)
#option.select_by(:value, '20180903')

# Find select option and click
driver.find_element(:id, "wt-his-select").find_element(:css,"option[value='20180904']").click

# Wait for Browser to load
sleep 5

# Aknowledge browser is back
puts "woken"

puts driver.find_element(:class, "sticky-wr").text


driver.quit



