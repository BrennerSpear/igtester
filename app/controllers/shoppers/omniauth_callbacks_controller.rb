class Shoppers::OmniauthCallbacksController < Devise::OmniauthCallbacksController

	def instagram

		email = extras["email"]
		if Shopper.where(email: email).exists?
			@shopper = Shopper.from_omniauth(request.env["omniauth.auth"], request.env["omniauth.params"])
			redirect_to pages_dashboard_path
			# redirect_to pages_home_path
		else
			@shopper = Shopper.from_omniauth(request.env["omniauth.auth"], request.env["omniauth.params"])
			redirect_to pages_dashboard_path
		end
	end

	def extras
		request.env["omniauth.params"]
	end

end 