class PagesController < ApplicationController
  def home
  end

  def dashboard
  	@shoppers = Shopper.all
  end
end
