class DriversController < ApplicationController
  require 'Savon'
  def index
  	@drivers = Driver.all
  end

  def new
  	 @driver = Driver.new
  	 @ds = Driver.all
  end
  
   def create
      @driver = Driver.new(params.require(:driver).permit(:first_name))
      if @driver.save

      #  @zip_code = ZipCode.initialize(params[:driver].to_s)
         @as = Driver.last.first_name
         @pl = 90210
    # client = Savon.client(wsdl: "http://www.webservicex.net/uszip.asmx?WSDL")
    # response = client.call(:get_info_by_zip,web: message: { "USZip" => @as })
    #  client = Savon.client(wsdl: "http://www.webservicex.net/airport.asmx?WSDL")
    # response = client.call(:get_airport_information_by_country, message: { "country" => @as })
     client = Savon.client(wsdl: "http://esb.dev.bcldb.com:25011/LDB_Retail/ProductService?WSDL")
    
    response = client.call(:get_product_by_sku, message: { "sku" => @as })
       @res = response
     if response.success?
       data = response.to_array(:get_info_by_zip_response, :get_info_by_zip_result, :new_data_set, :table).first
       if data
          @state = data[:state]
          @city = data[:city]
          @area_code = data[:area_code]
          @time_zone = data[:time_zone]
        
        end
      end
      


    	render "drivers/index" # driver index 
      else
     	render 'new'
      end
   end


# private
#    def driver_params
#     params.require(:driver).permit(:first_name)
#    end
 end
