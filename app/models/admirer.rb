class Admirer < ActiveRecord::Base
  validates :phone_number, presence: true
  
  has_many :messages
  has_many :likes
end
