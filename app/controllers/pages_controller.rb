class PagesController < ApplicationController
	before_action :authenticate_brand!, only: [:brand_dashboard]
	before_action :authenticate_shopper!, only: [:shopper_dashboard]

  def home
  	if current_brand
  		redirect_to brand_dashboard_path
  	elsif current_shopper
  		redirect_to shopper_dashboard_path
  	end
  end

  def brand_dashboard
  	@current_brand = current_brand
  end

  def shopper_dashboard
  	@current_shopper = current_shopper
  	binding.pry
  end
end
