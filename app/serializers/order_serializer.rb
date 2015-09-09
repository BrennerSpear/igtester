class OrderSerializer < ActiveModel::Serializer
	#DOLLARS PER LIKE IS WRONG
	attributes :id, :shop_id, :cents_per_like, :dollars_per_like, :max_total_allowed, :created_at

	has_one    :post  #, -> { includes :shopper}
	has_many   :rewards, through: :posts,  source: :reward

end
