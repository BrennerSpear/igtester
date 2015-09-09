class PostSerializer < ActiveModel::Serializer
	attributes :id, :shopper_id, :order_id, :type, :caption, :link, :image, :media_id, :tagged_accounts, :followers_generated, :likes, :created_at

	has_one    :reward
end
