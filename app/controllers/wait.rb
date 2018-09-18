require 'selenium-webdriver'
require 'watir'
require 'nokogiri'
require 'active_support'
require 'date'
require 'active_support/core_ext/integer/time'


options = Selenium::WebDriver::Chrome::Options.new(args: ['headless'])
driver = Selenium::WebDriver.for(:chrome, options: options)

# NEED TO CHANGE THE URL FOR EACH MONTH

driver.get('https://www.timeanddate.com/weather/uk/london/historic')

# Ad a day to the current day

d = Date.new(2018,9,5)
#puts d
#plusday = (d+1).strftime("%Y%m%d")
#puts plusday

# Find select option and click
#driver.find_element(:id, "wt-his-select").find_element(:css, "option[value='#{plusday}']").click

select = driver.find_element(:id, "wt-his-select")
alloptions = select.find_elements(:tag_name, 'option')
alloptions.each do |i|
puts i.attribute('value')
i.click
sleep 3
puts driver.find_element(:class, "sticky-wr").text

end

# run after all collected for month
v = (d+1.month).strftime("%m")
d = v
#plusday = (d+1).strftime("%Y%m%d")
puts v

driver.get('https://www.timeanddate.com/weather/uk/london/historic?month=#{plusday}&year=2009')


# Wait for Browser to load
#sleep 2

# Aknowledge browser is back
#puts "Awake :)"

#puts driver.find_element(:class, "sticky-wr").text

#driver.find_elements(xpath: "//table[@id='wt-his']//tr").each.with_index(1) do |_,index|
 # driver.find_elements(xpath: "//table[@id='wt-his']//tr[#{index}]/td").each do |cell|
   # print cell.text
 # end
 # puts '*****'
#end



driver.quit



