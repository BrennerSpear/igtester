class ShopSerializer < ActiveModel::Serializer
	attributes :id, :brand_id

	has_many   :orders
	has_many   :posts, through: :orders, source: :post
	has_many   :rewards, through: :posts,  source: :reward
end
