class Brand < ActiveRecord::Base
	include InstagramMethods
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	:recoverable, :rememberable, :trackable, :validatable
	#,:omniauthable, omniauth_providers: [:bigcommerce]

	has_one  :shop, inverse_of: :brand
	has_many :orders,  -> {uniq}, through: :shops,  source: :order
	has_many :posts,   -> {uniq}, through: :orders, source: :post
	has_many :rewards, -> {uniq}, through: :posts,  source: :reward
end
