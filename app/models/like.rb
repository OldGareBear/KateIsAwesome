class Like < ActiveRecord::Base
  validates :message_id, :liker, presence: true
end