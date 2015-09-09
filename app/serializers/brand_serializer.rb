class BrandSerializer < ActiveModel::Serializer
	attributes :id, :email, :uid, :nickname, :image, :bio, :website, :token

	has_one  :shop, inverse_of: :brand
	has_many :order,  through: :shops, source: :order
	has_many :post,   through: :orders, source: :post
	has_many :reward, through: :posts,  source: :reward
end
