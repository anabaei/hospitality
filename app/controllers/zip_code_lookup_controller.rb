class ZipCodeLookupController < ApplicationController
 
   require 'Savon'
  def index
  	 @zip_code = ZipCode.initialize(params[:zip_code].to_s)  #if params[:zip_code][:name].present?
  	
  	 # if params[:zip_code].present? 
  	 # 	 render :text => params[:zip_code].inspect
    #  end
  end

 
end
