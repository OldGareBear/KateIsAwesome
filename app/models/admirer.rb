class Admirer < ActiveRecord::Base
  validates :number, presence: true
  
  has_many :messages
  has_many :likes
end
