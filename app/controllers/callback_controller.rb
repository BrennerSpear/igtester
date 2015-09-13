class CallbackController < ApplicationController
	include Devise::Controllers::Rememberable
	skip_before_action :verify_authenticity_token, only: [:webhook]

	# def authorize
	# 	redirect_to Instagram.authorize_url(redirect_uri: "http://localhost:3000/auth/instagram/callback")
	# end

	def bigcommerce

		@brand = Brand.from_bc_omniauth(auth, extras)

		Bigcommerce.configure do |config|
			config.store_hash   = @brand.store_hash
			config.client_id    = ENV['BC_CLIENT_ID']
			config.access_token = @brand.bctoken
		end

		@webhook = Bigcommerce::Webhook.create(
			scope: 'store/order/*',
			destination: 'https://5cd6e141.ngrok.io/webhook'
		)

		binding.pry

		if @brand.persisted?
			remember_me(@brand)
		end

		redirect_to load_path

	end

	def webhook

		binding.pry

	end

	def instagram

		if extras["type"] == "shopper"
			@shopper = Shopper.from_omniauth(auth, extras)

			if @shopper.persisted?
				remember_me(@shopper)
			end

			redirect_to shopper_dashboard_path

		elsif extras["type"] == "brand"
			@brand = Brand.from_omniauth(auth, extras)


			if @brand.persisted?
				remember_me(@brand)
			end
			redirect_to brand_dashboard_path
		else
		end
	end


	private

	def auth
		request.env["omniauth.auth"]
	end

	def extras
		request.env["omniauth.params"]
	end


end


# response = Instagram.get_access_token(params[:code], redirect_uri: "http://localhost:3000/auth/instagram/callback")

# current_brand.uid = response.user.id
# current_brand.nickname = response.user.username
# current_brand.name = response.user.full_name
# current_brand.image = response.user.profile_picture
# current_brand.bio = response.user.bio
# current_brand.token = response.access_token
# current_brand.website = response.user.website
# current_brand.save!