class Message < ActiveRecord::Base
  validates :body, null: false
end
