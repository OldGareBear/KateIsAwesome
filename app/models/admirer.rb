class Admirer < ActiveRecord::Base
  validates :name, :number, presence: true
end
