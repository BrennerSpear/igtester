class Shopper < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:instagram]


  def self.from_omniauth(auth, params)
  		shopper = Shopper.find_or_create_by(provider: auth.provider, uid: auth.uid)
  		shopper.email 		= params["email"]
  		shopper.password 	= Devise.friendly_token[0,20]
  		shopper.nickname 	= auth.info.nickname
  		shopper.name 		= auth.info.name
  		shopper.image 		= auth.info.image
  		shopper.website		= auth.info.website
  		shopper.token 		= auth.credentials.token
  		shopper.save!
  		binding.pry
  end

  def client
    @instagram_client ||= Instagram.client(access_token: token)
  end

  def media
    client.user_media_feed
  end

  def user
    client.user
  end

  def recent_media
    client.user_recent_media
  end


end 
