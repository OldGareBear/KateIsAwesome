class Like < ActiveRecord::Base
  validates :message_id, :admirer_id, presence: true
  
  belongs_to :message
  belongs_to :admirer
end
