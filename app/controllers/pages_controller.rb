class PagesController < ApplicationController
  def entrance
  	if current_brand
  		redirect_to pages_brand_dashboard_path
    elsif current_shopper
      redirect_to pages_shopper_dashboard_path
  	end
  end

  def brand_dashboard
  	@current_brand = current_brand
  end

  def shopper_dashboard
    @current_shopper = current_shopper
  end

  def index
  end
end
