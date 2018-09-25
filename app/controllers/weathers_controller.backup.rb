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

@d = Date.new(2010,1,01) # STARTING POINT MUST START FROM BEGINNG ON TIME!!!

# Keep repeating until todays date is hit 
while @d < Date.new(2010,2,01) # FINISHING DATE
  
# Date and location params
@mymonth = (@d).strftime("%m")
@myyear = (@d).strftime("%y")
@mycity = "london"  # This is case sensitive - must be lowercase

# Selenium Configuration
options = Selenium::WebDriver::Chrome::Options.new(args: ['headless']) 
$driver = Selenium::WebDriver.for(:chrome, options: options)

puts "https://www.timeanddate.com/weather/uk/#{@mycity}/historic?month=#{@mymonth}&year=20#{@myyear}"

# Request with params
$driver.get("https://www.timeanddate.com/weather/uk/#{@mycity}/historic?month=#{@mymonth}&year=20#{@myyear}")
@drives = $driver.get("https://www.timeanddate.com/weather/uk/#{@mycity}/historic?month=#{@mymonth}&year=20#{@myyear}")

select = $driver.find_element(:id, "wt-his-select")
@alloptions = select.find_elements(:tag_name, 'option')
puts "Here we go!"
puts "https://www.timeanddate.com/weather/uk/london/historic?month=#{@mymonth}&year=20#{@myyear}"

@alloptions.drop(1).each do |i| # skip 'previous 24 hours' drop down option
@allthem = i.attribute('value')
i.click
sleep 1

timesnow = ["00:50","01:50","02:50","03:50","04:50","05:50","06:50","07:50","08:50","09:50","10:50","11:50","12:50","13:50","14:50","15:50","16:50","17:50","18:50","19:50","20:50","21:50","22:50","23:50"]
tablecells = []
tablecells.clear

$driver.find_elements(xpath: "//table[@id='wt-his']/tbody/tr").first(24).each.with_index(1) do |_,index|   # Find each table ROW 
$driver.find_elements(xpath: "//table[@id='wt-his']//tr[#{index}]/td[position()>1]").each do |cell1| # Find each CELL for the INDEX ROW above 

$line = cell1.text.split(',')
tablecells.push($line)

$newdex1 = index
@newdex2 = $newdex1 - 1
@newdex2.to_i

timesnow[@newdex2]

end

Weather.create :city => "#{@mycity}", :date => "#{@allthem}", :time => "#{timesnow[@newdex2]}", :temperature => "#{tablecells[0]}", :description => "#{tablecells[1]}", :windspeed => "#{tablecells[2]}", :humidity => "#{tablecells[4]}", :barometer => "#{tablecells[5]}", :visibility => "#{tablecells[6]}"

tablecells.clear

end #end cell1 
end #end row index


def after
  
@newdate = @d+1.month
  
puts "running after method"

@mymonth2 = (@newdate).strftime("%m")
@myyear2 = (@newdate).strftime("%y")

$driver.get("https://www.timeanddate.com/weather/uk/london/historic?month=#{@mymonth2}&year=20#{@myyear2}")

# Re-define @d as @newdate
@d = @newdate

puts "NEWDATE WORKING #{@newdate}"
puts "NEWDATE WORKING #{@newdate}"
puts "NEWDATE WORKING #{@newdate}"


end

after # Run after

end #endwhile


puts "loop cycle has completed PLACE NEW TOWN FUNCTION HERE"


#def nexttown
  

# locations = [”aberystwyth”,”alnwick”,”armagh”,”aylesbury”,”bangor”,”barnsley”,”basildon”,”bath”,”belfast”,”berwick-upon-tweed”,”bicester”,”bideford”,”birmingham”,”blackburn”,”blackpool”,”blandford forum”,”bodmin”,”bolton”,”bournemouth”,”bracknell”,”bradford”,”brentwood”,”bridlington”,”brighton”,”bristol”,”bromley”,”burnley”,”bury”,”cambridge”,”canterbury”,”canvey island”,”cardiff”,”carlisle”,”caversham”,”chatham”,”chatteris”,”chelmsford”,”cheltenham”,”chesham”,”chester”,”chesterfield”,”chichester”,”clacton-on-sea”,”cleethorpes”,”clitheroe”,”coatbridge”,”colchester”,”colwyn bay”,”coventry”,”craigavon”,”crawley”,”croydon”,”darlington”,”derby”,”doncaster”,”dover”,”dudley”,”dumbarton”,”dundee”,”dunfermline”,”durham”,”eastbourne”,”edinburgh”,”ely”,”enfield”,”epsom”,”exeter”,”falkirk”,”fauldhouse”,”faversham”,”felixstowe”,”fort william”,”fraserburgh”,”gillingham”,”glasgow”,”glastonbury”,”great yarmouth”,”greenwich borough”,”grimsby”,”guildford”,”hartlepool”,”harwich”,”hastings”,”hatfield”,”haywards heath”,”hexham”,”high wycombe”,”hinckley”,”hitchin”,”holyhead”,”horsham”,”huddersfield”,”hugh town”,”huntingdon”,”inverness”,”ipswich”,”jarrow”,”kelso”,”kendal”,”kettering”,”kingslynn”,”kingstonuponhull”,”kirkwall”,”lancaster”,”launceston”,”leeds”,”leicester”,”lerwick”,”lichfield”,”lincoln”,”lindisfarne”,”lisburn”,”liverpool”,”london”,”londonderry”,”loughborough”,”loughton”,”lowestoft”,”luton”,”maidstone”,”manchester”,”market harborough”,”middlesbrough”,”miltonkeynes”,”minehead”,”morpeth”,”newcastleupontyne”,”newport”,”newport”,”newtown”,”northampton”,”norwich”,”nottingham”,”oban”,”oldham”,”omagh”,”oxford”,”penrith”,”penzance”,”perth”,”peterborough”,”pitlochry”,”plymouth”,”poole”,”portree”,”portsmouth”,”preston”,”prestwick”,”reading”,”ripon”,”romsey”,”rotherham”,”runcorn”,”salford”,”salisbury”,”sheffield”,”shrewsbury”,”silverstone”,”skegness”,”skelmersdale”,”slough”,”solihull”,”southampton”,”southend-on-sea”,”standrews”,”stdavids”,”sthelens”,”stafford”,”stevenage”,”stirling”,”stockport”,”stoke-on-trent”,”stornoway”,”sudbury”,”sunderland”,”suttoncoldfield”,”swanage”,”swansea”,”swindon”,”taunton”,”telford”,”thornton-cleveleys”,”truro”,”uckfield”,”uxbridge”,”wakefield”,”walsall”,”warrington”,”watford”,”wellingborough”,”westbromwich”,”weston-super-mare”,”weymouth”,”whitstable”,”winchester”,”witney”,”wokingham”,”wolverhampton”,”worcester”,”worthing”,”yatton”,”yeovil”,”york”]
puts "https://www.timeanddate.com/weather/uk/#{@mycity}/historic?month=#{@mymonth2}&year=20#{@myyear2}"
#loop_one # run loop 1 with new data

#end #endnexttown

end #endwhile

#nexttown



























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






