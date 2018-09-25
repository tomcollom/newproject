require 'selenium-webdriver'
require 'active_support'
require 'date'
require 'active_support/core_ext/integer/time'
require 'uri'
require 'active_record'

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

# Keep repeating until todays date is hit 
while @d < Date.today

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

$timesnow = ["00:50","01:50","02:50","03:50","04:50","05:50","06:50","07:50","08:50","09:50","10:50","11:50","12:50","13:50","14:50","15:50","16:50","17:50","18:50","19:50","20:50","21:50","22:50","23:50"]

tablecells = []
tablecells.clear

$driver.find_elements(xpath: "//table[@id='wt-his']/tbody/tr").each.with_index(1) do |_,index|   # Find each table ROW 
$driver.find_elements(xpath: "//table[@id='wt-his']//tr[#{index}]/td[position()>1]").each do |cell1| # Find each CELL for the INDEX ROW above 

$line = cell1.text.split(',')
tablecells.push($line)

$newdex1 = index
@newdex2 = $newdex1 - 1
@newdex2.to_i 

end

puts $timesnow[@newdex2]

#$timesnow[$newdex2]

puts tablecells[0]

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

# NEED A FUNCTION HERE TO CHANGE THE CITY NAME ONCE WHILE LOOP HAS COLLECTED UP UNTIL TODAY 

driver.quit



