class Admirer < ActiveRecord::Base
  validates :name, :number, presence: true
  
  has_many :messages
end
