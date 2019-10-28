class VideoSerializer < ActiveModel::Serializer
  attributes :id, :link, :title, :description, :created_at, :updated_at

  has_one :user
end
