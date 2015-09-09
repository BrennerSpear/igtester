class Shoppers::OmniauthCallbacksController < Devise::OmniauthCallbacksController
	include Devise::Controllers::Rememberable

	def instagram
		# email = extras["email"]

		#Make sure no one tries to add an email address in the url
		# if Shopper.where(email: email).blank?
			
			@shopper = Shopper.from_omniauth(auth, extras)

			if @shopper.persisted?
				remember_me(@shopper)
			end

			redirect_to shopper_dashboard_path
		# else
		# 	flash[:notice] = "That email is already taken and you knew it!"
		# 	redirect_to denied_request_path	
		# end
		
	end




	# # DDOS prevention for Instagram
	# def challenge
	# 	binding.pry
	# 	render text: params['hub.challenge']
	# end

  private

	def auth
		request.env["omniauth.auth"]
	end

	def extras
		request.env["omniauth.params"]
	end

end