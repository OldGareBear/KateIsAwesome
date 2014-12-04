class Admirer < ActiveRecord::Base
  validates :name, :number, presence: true
  
  has_many :messages
  has_many :likes
end
