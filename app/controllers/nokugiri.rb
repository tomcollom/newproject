      url = "https://www.timeanddate.com/weather/uk/london/historic?month=1&year=2010"                
      unparsed_page = HTTParty.get(url)
      parsed_page = Nokogiri::HTML(unparsed_page)
      job_listings = parsed_page.css('tr')
      job_listings.each do |job_listing|
        
  
