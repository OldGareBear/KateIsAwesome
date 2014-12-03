require 'twilio-ruby'

class TwilioController < ApplicationController
  include Webhookable
  
  after_filter :set_header
  
  skip_before_action :verify_authenticity_token
  
  def process_sms
    body = params["Body"]
    sender = params["From"]
   
    # check to see if the body is a vote
    if body.to_i > 0
      process_like(body.to_i, sender)
      return
    end
    
    city = params["FromCity"]
    state = params["FromState"]
    
    response = Twilio::TwiML::Response.new do |resp|
      resp.Text "Thanks for telling us what you love about Kate!."
    end
    
    message = Message.new(body: body, from: sender, city: city, state: state)
   
    message.save!

    thanks(sender)
  end
  
  def process_like(id, sender)
    
    message = Message.find(id)
    
    like = Like.new(message_id: id, liker: sender)
    
    return unless like
    
    like.save!
  end

  protected

  def thanks(sender)
    p "~~~~~~~~~~~~~ We entered the thanks method"
    sid = ENV["TWILIO_SID"]
    token = ENV["TWILIO_AUTH_TOKEN"]
    twilio_number = "7328565344"

    @client = Twilio::REST::Client.new sid, token

    @client.account.sms.messages.create(
      :from => "+1#{twilio_number}"),
      :to => sender
      :body => "Thanks for sharing what you love about Kate =)"
    )
  end
end