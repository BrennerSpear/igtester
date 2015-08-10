class Shoppers::OmniauthCallbacksController < Devise::OmniauthCallbacksController

	def instagram
		@shopper = Shopper.from_omniauth(request.env["omniauth.auth"], request.env["omniauth.params"])
		binding.pry		
		redirect_to pages_dashboard_path
	end


end