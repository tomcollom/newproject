

def task

       # Start Mechanize and add URL

       agent = Mechanize.new
       page = agent.get("https://www.timeanddate.com/weather/uk/london/historic?month=7&year=2011")

       puts page.title
        
       #  puts page.at('#wt-his-select')
       #  puts page.at('#wt-his-select')
       #  puts page.select_links('#wt-his-select')
        
       # Get all of the links in the page object
       # page.links.each do |link|
       # puts page.link_with(:text => 'Jan 1')
        
       # my_form = page.form('month_form')
       # my_form.q = 'ruby mechanize'
       # puts my_form
       
       # my_form2 = form.field_with(:name => 'month_form').options[1].select
       
       # puts my_form2
        
       #puts my_form.field_with(:name => 'month_form').click
       # form = page.forms.first
       # puts form
       # end
       
      #page.form_with(:name => 'month_form').options[3].select

      checkboxForm = page.form_with(:action => '/weather/uk/london/historic')
    #   checkboxForm = page.option_with(:id => "wt-his-select")

         
    pp checkboxForm.field_with(:value => "20110701").value = "testmem"
      
  
      



     # search_form = page.form_with :name => "nil"
     # search_form.field_with(:name => "q").value = "fooxxx"
     # search_results = agent.submit search_form
     # puts search_results.body

byebug

end

task

    

    
        
