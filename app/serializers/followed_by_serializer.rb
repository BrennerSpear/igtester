class FollowedBySerializer < ActiveModel::Serializer
  attributes :id, :followable_id, :followable_type, :follower_id
end
