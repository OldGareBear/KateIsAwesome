class Message < ActiveRecord::Base
  validates :body, null: false
  
  has_many :likes
end
