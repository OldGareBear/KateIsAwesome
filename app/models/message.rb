class Message < ActiveRecord::Base
  validates :body, null: false
  
  has_many :likes
  belongs_to :admirer
end
