class ShopperSerializer < ActiveModel::Serializer
  attributes :id, :email, :uid, :nickname, :name, :image, :bio, :website, :token, :follower_count, :following_count, :media_count

  has_many :posts
  has_many :rewards, through: :posts,  source: :reward
end
