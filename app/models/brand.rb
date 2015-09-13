class Brand < ActiveRecord::Base
	include InstagramMethods
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	:recoverable, :rememberable, :trackable, :validatable

	has_one  :shop, inverse_of: :brand
	has_many :orders,  -> {uniq}, through: :shops,  source: :order
	has_many :posts,   -> {uniq}, through: :orders, source: :post
	has_many :rewards, -> {uniq}, through: :posts,  source: :reward

	def self.from_omniauth(auth, params)
		brand = Brand.find_or_create_by(provider: auth.provider, uid: auth.uid) do |b|
			b.password  = Devise.friendly_token[0,20]
			b.nickname  = auth.info.nickname
			b.name      = auth.info.name
			b.image     = auth.info.image
			b.website   = auth.info.website
			b.token     = auth.credentials.token
			b.email 		= "placeholder@placeholder.com"
			b.save!
		end
	end

	def self.from_bc_omniauth(auth, params)
		brand = Brand.find_or_create_by(provider: auth.provider, bcid: auth.uid) do |b|
			b.password  = Devise.friendly_token[0,20]
			b.name 		= auth.info.name
			b.email 	= auth.info.email
			b.bcid		= auth.uid
			b.bctoken  	= auth.credentials.token.token
			b.store_hash= auth.extra.raw_info.context.split('/')[1]
			binding.pry
			b.save!
		end

		#it seems they switch the token (maybe when you uninstall?) so we have to always update
		brand.bctoken  	= auth.credentials.token.token

		brand
	end

end
