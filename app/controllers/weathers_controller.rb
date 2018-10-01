require 'selenium-webdriver'
require 'active_support'
require 'date'
require 'active_support/core_ext/integer/time'
require 'uri'
require 'active_record'

class WeathersController < ApplicationController
helper_method :loop_one
before_action :set_weather, only: [:show, :edit, :update, :destroy]

def index
def loop_one
  
# If using @12345 code the URL needs /uk/ removing!!	
# coded  ["@2633948","@2645425","@2657770","@2649312","@2638324","@2639272","@2654200","@2648657","@7295998","@7295192","@2655613","@2642214","@2643266","@2647428","@2633485","@2645280","@2648773","@2655186","@2647632","@2656295","@2656241","@2648187","@2643186","@2650396","@2657540","@2647317","@2634686","@2651621","@2654938","@2644204","@2645605","@2640358","@2647570","@2642135","@2640677"].each do |location|
["watford","brighton","southampton","burnley","cardiff","liverpool","manchester","leicester","newcastle","huddersfield","leeds","middlesbrough","west-bromwich","sheffield","derby","bristol","nottingham","norwich","blackburn","birmingham","swansea","bolton","stoke-on-trent","rotherham","reading","ipswich","preston","peterborough","portsmouth","sunderland","doncaster","walsall","barnsley","blackpool","luton","coventry","southend-on-sea","high-wycombe","shrewsbury","bradford","oxford","plymouth","lincoln","exeter","colchester","carlisle","oldham","swindon","stevenage","yeovil","bury","milton-keynes","crawley","cheltenham","cambridge","northampton","grimsby","salford","hartlepool","solihull","chesterfield","bromley","maidstone","dover","edinburgh","glasgow","aberdeen","dundee"].each do |location|
	
@mycity = location

@d = Date.new(2009,1,01) # STARTING DATE

# begin with retry
max_retries = 1000
  times_retried = 0

  begin
  
while @d < Date.new(2018,2,01) # FINISHING DATE - MUST BE WHOLE DATE E.G 01 JAN - MIDDLE WILL NOT WORK
	
# Date and location params
@mymonth = (@d).strftime("%m")
@myyear = (@d).strftime("%y")

# Selenium Configuration

options = Selenium::WebDriver::Chrome::Options.new(args: ['headless']) 
$driver = Selenium::WebDriver.for(:chrome, options: options)

$driver.get("https://www.timeanddate.com/weather/uk/#{@mycity}/historic?month=#{@mymonth}&year=20#{@myyear}")
@drives = $driver.get("https://www.timeanddate.com/weather/uk/#{@mycity}/historic?month=#{@mymonth}&year=20#{@myyear}")

select = $driver.find_element(:id, "wt-his-select")
@alloptions = select.find_elements(:tag_name, 'option')
puts "Here we go!"
puts "https://www.timeanddate.com/weather/uk/#{@mycity}/historic?month=#{@mymonth}&year=20#{@myyear}"

$valuebox = []

@alloptions.each do |i| # skip 'previous 24 hours' drop down option
@allthem = i.attribute('value')
i.click
sleep 1

#Validate that the month on the page matches the month of the URL
quick =  i.attribute('value').to_i
remday = quick.to_s[0..-3].to_i # remove day
puts remday

myyear2 = (@d).strftime("%Y")
$valuebox.push(remday) #push into array
current = myyear2 + @mymonth

if $valuebox.include?(current.to_i) 
		puts "DOES INCLUDE - PROCEED TO SCRAPE"
		
		# REST OF SCRAPE FUNCTION

 #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  # 
	#  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  # 
	 #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  # 
	
#timesnow = ["00:50","01:50","02:50","03:50","04:50","05:50","06:50","07:50","08:50","09:50","10:50","11:50","12:50","13:50","14:50","15:50","16:50","17:50","18:50","19:50","20:50","21:50","22:50","23:50"]
tablecells = []
tablecells.clear

realtimes = []
realtimes.clear

$driver.find_elements(xpath: "//table[@id='wt-his']/tbody/tr")[0..-1].each.with_index(1) do |_,index|   # Find each table ROW 

$driver.find_elements(xpath: "//*[@id='wt-his']/tbody/tr[#{index}]/th").each do |cell2| # Find each TH for the INDEX ROW above
$line2 = cell2.text.split(',')
realtimes.push($line2)
end

$driver.find_elements(xpath: "//*[@id='wt-his']/tbody/tr[#{index}]/td[position()>1]").each do |cell1| # Find each CELL for the INDEX ROW above 
$line = cell1.text.split(',')
tablecells.push($line)

$newdex1 = index
@newdex2 = $newdex1 - 1
@newdex2.to_i

realtimes[@newdex2]

end

Weather.create :city => "#{@mycity}", :date => "#{@allthem}", :time => "#{realtimes[@newdex2]}", :temperature => "#{tablecells[0]}", :description => "#{tablecells[1]}", :windspeed => "#{tablecells[2]}", :humidity => "#{tablecells[4]}", :barometer => "#{tablecells[5]}", :visibility => "#{tablecells[6]}"

tablecells.clear

end
realtimes.clear
end 
end # PLACE THIS END JUST BEFORE END OF WHILE LOOP BEFORE AFTER SO NEXT MONTH IS ADDED AND LOOP STARS AGAIN FOR NON-VALIDATED 

$valuebox.clear

def after
sleeps = rand(1..2)	
sleep sleeps
@newdate = @d+1.month
@mymonth2 = (@newdate).strftime("%m")
@myyear2 = (@newdate).strftime("%y")
$driver.get("https://www.timeanddate.com/weather/uk/london/historic?month=#{@mymonth2}&year=20#{@myyear2}")
@d = @newdate

$driver.quit #kill instance of driver to stop memory issues 

end

after

end # while loop END

#rescue
 rescue Net::ReadTimeout => error
    if times_retried < max_retries
      times_retried += 1
      puts "Failed to <do the thing>, retry #{times_retried}/#{max_retries}"
      retry
    else
      puts "Exiting script. <explanation of why this is unlikely to recover>"
      exit(1)
    end
  end

end # each.do location list
end #loop one

@weathers = Weather.all
	
end

	# GET /weathers/1
	# GET /weathers/1.json
	def show
	end

	# GET /weathers/new
	def new
		@weather = Weather.new
	end

	# GET /weathers/1/edit
	def edit
	end

	# POST /weathers
	# POST /weathers.json
	def create
		@weather = Weather.new(weather_params)

		respond_to do |format|
			if @weather.save
				format.html { redirect_to @weather, notice: 'Weather was successfully created.' }
				format.json { render :show, status: :created, location: @weather }
			else
				format.html { render :new }
				format.json { render json: @weather.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /weathers/1
	# PATCH/PUT /weathers/1.json
	def update
		respond_to do |format|
			if @weather.update(weather_params)
				format.html { redirect_to @weather, notice: 'Weather was successfully updated.' }
				format.json { render :show, status: :ok, location: @weather }
			else
				format.html { render :edit }
				format.json { render json: @weather.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /weathers/1
	# DELETE /weathers/1.json
	def destroy
		@weather.destroy
		respond_to do |format|
			format.html { redirect_to weathers_url, notice: 'Weather was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_weather
			@weather = Weather.find(params[:id])
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def weather_params
			params.require(:weather).permit(:city, :date, :time, :temperature, :description, :windspeed)
		end
end









