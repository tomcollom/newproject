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
 
# main loop
def loop_one
  
@d = Date.new(2018,9,01)

# Keep repeating until todays date is hit 
while @d < Date.today
  
# Date and location params
@mymonth = (@d).strftime("%m")
@myyear = (@d).strftime("%y")
@mycity = "London"

@timelook = Time.now

# Selenium Configuration
options = Selenium::WebDriver::Chrome::Options.new(args: ['headless']) 
$driver = Selenium::WebDriver.for(:chrome, options: options)

# Request with params
$driver.get("https://www.timeanddate.com/weather/uk/#{@mycity}/historic?month=#{@mymonth}&year=20#{@myyear}")
@drives = $driver.get("https://www.timeanddate.com/weather/uk/#{@mycity}/historic?month=#{@mymonth}&year=20#{@myyear}")

select = $driver.find_element(:id, "wt-his-select")
@alloptions = select.find_elements(:tag_name, 'option')
puts "Here we go!"
puts "https://www.timeanddate.com/weather/uk/london/historic?month=#{@mymonth}&year=20#{@myyear}"

@alloptions.each do |i|
@allthem = i.attribute('value')
i.click
sleep 3

timesnow = ["00:50","01:50","02:50","03:50","04:50","05:50","06:50","07:50","08:50","09:50","10:50","11:50","12:50","13:50","14:50","15:50","16:50","17:50","18:50","19:50","20:50","21:50","22:50","23:50"]
tablecells = []
tablecells.clear

$driver.find_elements(xpath: "//table[@id='wt-his']/tbody/tr").each.with_index(1) do |_,index|   # Find each table ROW 
$driver.find_elements(xpath: "//table[@id='wt-his']//tr[#{index}]/td[position()>1]").each do |cell1| # Find each CELL for the INDEX ROW above 

$line = cell1.text.split(',')
tablecells.push($line)

$newdex1 = index
$newdex2 = $newdex1 + 1

end


Weather.create :city => "#{@mycity}", :date => "#{@allthem}", :time => "#{timesnow[$newdex2]}", :temperature => "#{tablecells[0]}", :description => "#{tablecells[1]}", :windspeed => "#{tablecells[2]}"


tablecells.clear

end #end cell1 
end #end row index
  
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

end #endwhile

# pkill -9 -f puma

@student_count = "Test Variable Output"
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






#@timesnow = ["00:50","12:50","01:50","02:50","03:50","04:50","05:50","06:50","07:50","08:50","09:50","10:50","11:50","12:50","13:50"]
#@timesnow.each do |look|
 # @fin = look






