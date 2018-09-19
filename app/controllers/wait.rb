require 'selenium-webdriver'
require 'active_support'
require 'date'
require 'active_support/core_ext/integer/time'
require 'uri'

# Enter Start Date for Scrape
@d = Date.new(2016,11,10)

# Format date and pass to URL
mymonth = (@d).strftime("%m")
myyear = (@d).strftime("%y")

# Selenium Configuration
options = Selenium::WebDriver::Chrome::Options.new(args: ['headless'])
$driver = Selenium::WebDriver.for(:chrome, options: options)

# Request with params
$driver.get("https://www.timeanddate.com/weather/uk/london/historic?month=#{mymonth}&year=20#{myyear}")

# Keep repeating until this is met
while @d >= 1

# main loop
def loop_one
select = $driver.find_element(:id, "wt-his-select")
alloptions = select.find_elements(:tag_name, 'option')
puts "spun again"
puts "https://www.timeanddate.com/weather/uk/london/historic?month=#{@mymonth}&year=20#{@myyear}"

alloptions.each do |i|
puts i.attribute('value')
i.click
sleep 1

#puts $driver.find_element(:class, "sticky-wr").text


#Formatting Output / Iterate for DB Entry 

$driver.find_elements(xpath: "//table[@id='wt-his']//tr").each.with_index(1) do |_,index|
$driver.find_elements(xpath: "//table[@id='wt-his']//tr[#{index}]/th|.//table[@id='wt-his']//tr[#{index}]/td[position()>1]").each do |cell1|
print cell1.text.split(',')
end

puts '*****END_OF_LINE*******'
end


end

#Add a month to date 
@newdate = @d+1.month

end #end loopone
loop_one # Run loop_one

def after
 puts "running after method"
# run after all collected for month
mymonth = (@newdate).strftime("%m")
myyear = (@newdate).strftime("%y")

$driver.get("https://www.timeanddate.com/weather/uk/london/historic?month=#{mymonth}&year=20#{myyear}")

# Re-define @d as @newdate
@d = @newdate
end
after # Run after

end #end main while loop




driver.quit



