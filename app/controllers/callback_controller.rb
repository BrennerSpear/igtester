class CallbackController < ApplicationController

	def authorize
		redirect_to Instagram.authorize_url(redirect_uri: "http://localhost:3000/auth/instagram/callback")
	end

	def instagram
		response = Instagram.get_access_token(params[:code], redirect_uri: "http://localhost:3000/auth/instagram/callback")
		
		current_brand.uid = response.user.id
		current_brand.nickname = response.user.username
		current_brand.name = response.user.full_name
		current_brand.image = response.user.profile_picture
		current_brand.bio = response.user.bio
		current_brand.token = response.access_token
		current_brand.website = response.user.website
		current_brand.save!

		binding.pry

		redirect_to pages_dashboard_path

	end
end