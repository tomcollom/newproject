require 'selenium-webdriver'
require 'active_support'
require 'date'
require 'active_support/core_ext/integer/time'
require 'uri'
require 'active_record'


class WeathersController < ApplicationController
helper_method :loop_one
before_action :set_weather, only: [:show, :edit, :update, :destroy]

# Each controller action is a page and data query :: the method will be run to give the data for that template
# GET /weathers.json

def index


# main loop
def loop_one
  
  
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

@drives = $driver.get("https://www.timeanddate.com/weather/uk/london/historic?month=#{mymonth}&year=20#{myyear}")
  
select = $driver.find_element(:id, "wt-his-select")
@alloptions = select.find_elements(:tag_name, 'option')
puts "spun again"
puts "https://www.timeanddate.com/weather/uk/london/historic?month=#{@mymonth}&year=20#{@myyear}"

Weather.create :city => "Southampton", :date => "05032016", :time => "09:50am", :temperature => "60 Deg", :description => "cloudy", :windspeed => "88%"

@alloptions.each do |i|
@allthem = puts i.attribute('value')
i.click
sleep 1

$driver.find_elements(xpath: "//table[@id='wt-his']/tbody/tr").each.with_index(1) do |_,index|
$driver.find_elements(xpath: "//table[@id='wt-his']//tr[#{index}]|.//table[@id='wt-his']//tr[#{index}]/td[position()>1]").each do |cell1|
$line = cell1.text.split(',')
print $line

end
puts '*****END_OF_LINE*******'
end

end
end






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
