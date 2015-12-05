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
   # client = Savon.client(wsdl: "http://www.webservicex.net/uszip.asmx?WSDL")
 ############################# ############################# ############################# ######################################
 ################################  SETIGN UP SAVON CLIENT AND THEN MAKE A REQUEST TO INVOKE ####################################### 
 ############################# ############################# #############################  ##################################### 
     client = Savon.client(wsdl: "http://esb.dev.bcldb.com:25011/LDB_Retail/ProductService?WSDL") 

   ## BELOW I USE SOAP UI READY CODE TO MAKE A REQUEST ##
    rest = %q(
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:prod="http://productservice.services.bcldb.com">
           <soapenv:Header/>
              <soapenv:Body>
                <prod:productBySKURequest>
                   <prod:sku>)+@as.to_s+%q(</prod:sku>
                </prod:productBySKURequest>
             </soapenv:Body>
           </soapenv:Envelope>
            )
    response = client.call(:get_product_by_sku, xml: rest)
    #  client = Savon.client(wsdl: "http://www.webservicex.net/airport.asmx?WSDL")
    # response = client.call(:get_airport_information_by_country, message: { "country" => @as })
    #  client = Savon.client(wsdl: "http://esb.dev.bcldb.com:25011/LDB_Retail/ProductService?WSDL") 
    # response = client.call(:get_product_by_sku, message: { "sku" => @as })

 #############################  ENDING HITING THE SOAP  SERVICE ####################################### 
 ############################## -##############################- ######################################## 

       @res = response.to_array
         if response.success?
           data = response.to_array(:product_by_sku_response, :product).first
     #########(only for zip code call) This part is to split response into parts that we want ###### ############################## ##############################
       # data = response.to_array(:get_info_by_zip_response, :get_info_by_zip_result, :new_data_set, :table).first # here we dig into nested hash response to zip code 
       # @data = response.to_array
        if data
       #    @state = data[:state]
       #    @city = data[:city]
       #    @area_code = data[:area_code]
       #    @time_zone = data[:time_zone]
            @name = data[:product_name]
         end
      ############################## ############################## ############################## ##############################
         
         end

      render "drivers/new" # driver index 
      else
      render 'drivers/index'
      end
   end
  
      def update
      @driver = Driver.new(params.require(:driver).permit(:first_name))
      if @driver.save

      #  @zip_code = ZipCode.initialize(params[:driver].to_s)
         @as = Driver.last.first_name
   # client = Savon.client(wsdl: "http://www.webservicex.net/uszip.asmx?WSDL")
 ############################# ############################# ############################# ######################################
 ################################  SETIGN UP SAVON CLIENT AND THEN MAKE A REQUEST TO INVOKE ####################################### 
 ############################# ############################# #############################  ##################################### 
     client = Savon.client(wsdl: "http://services.dev.bcldb.com:25211/ProductService/ProductPort?wsdl") 

   ## BELOW I USE SOAP UI READY CODE TO MAKE A REQUEST ##
    rest = %q(
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:prod="http://productservice.services.bcldb.com">
           <soapenv:Header/>
              <soapenv:Body>
                <prod:productBySKURequest>
                   <prod:sku>)+@as.to_s+%q(</prod:sku>
                </prod:productBySKURequest>
             </soapenv:Body>
           </soapenv:Envelope>
            )
    response = client.call(:get_product_by_sku, xml: rest)
    #  client = Savon.client(wsdl: "http://www.webservicex.net/airport.asmx?WSDL")
    # response = client.call(:get_airport_information_by_country, message: { "country" => @as })
    #  client = Savon.client(wsdl: "http://esb.dev.bcldb.com:25011/LDB_Retail/ProductService?WSDL") 
    # response = client.call(:get_product_by_sku, message: { "sku" => @as })

 #############################  ENDING HITING THE SOAP  SERVICE ####################################### 
 ############################## -##############################- ######################################## 

       @res = response.to_array(:product_by_sku_response, :product).first
         if response.success?
           data = response.to_array(:product_by_sku_response, :product).first
     #########(only for zip code call) This part is to split response into parts that we want ###### ############################## ##############################
       # data = response.to_array(:get_info_by_zip_response, :get_info_by_zip_result, :new_data_set, :table).first # here we dig into nested hash response to zip code 
       # @data = response.to_array
        if data
       #    @state = data[:state]
       #    @city = data[:city]
       #    @area_code = data[:area_code]
       #    @time_zone = data[:time_zone]
            @name = data[:product_name]
            @brand = data[:brand]
           

         end
      ############################## ############################## ############################## ##############################
         
         end

      render "drivers/new" # driver index 
      else
      render 'drivers/index'
      end
   end

# private
#    def driver_params
#     params.require(:driver).permit(:first_name)
#    end
 end

