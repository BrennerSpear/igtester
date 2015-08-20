class PagesController < ApplicationController
  def home
  	if current_brand
  		redirect_to pages_dashboard_path
  	end
  end

  def dashboard
  	@shoppers = Shopper.all
  	@current_brand = current_brand
  end
end
