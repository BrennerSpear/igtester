class Brand < ActiveRecord::Base
  include InstagramMethods

  has_one  :shop, inverse_of: :brand 
  has_many :orders,  -> {uniq}, through: :shops,  source: :order
  has_many :posts,   -> {uniq}, through: :orders, source: :post
  has_many :rewards, -> {uniq}, through: :posts,  source: :reward 
end