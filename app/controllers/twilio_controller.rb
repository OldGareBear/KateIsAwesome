require 'twilio-ruby'

class TwilioController < ApplicationController
  include Webhookable
  
  after_filter :set_header
  
  skip_before_action :verify_authenticity_token
  
  def process_sms
    body = params["Body"]
    sender = params["From"]
    city = params["FromCity"]
    state = params["FromState"]
    
    # check for signature
    if body =~ /\*(\w+\s)+/ # a space is always added to the message
      # grab the signature
      signature = body.match(/\*(\w+\s)+/)
      # chop off the signature
      body.sub!(/\*(\w+\s)+/, "")
      process_signature(signature, sender)
    end 
   
    # check to see if the body is a vote
    if body.to_i > 0
      process_like(body.to_i, sender)
      return
    end
    
    response = Twilio::TwiML::Response.new do |resp|
      resp.Text "Thanks for telling us what you love about Kate!."
    end
    
    message = Message.new(body: body, from: sender, city: city, state: state)
   
    message.save!

    thanks(sender)
  end

  protected
  
  def process_like(id, sender)
    message = Message.find(id)
    like = Like.new(message_id: id, liker: sender)
    
    return unless like
    like.save!
  end
  
  def process_signature(signature, sender)
    puts "~~~~signature being processed~~~~"
    
    #don't allow duplicate entries for the same number
    return if Admirer.find_by_sender(sender)
    
    admirer = Admirer.new(name: signature, phone_number: sender)
    admirer.save!
  end

  def thanks(sender)
    sid = ENV["TWILIO_SID"]
    token = ENV["TWILIO_AUTH_TOKEN"]
    twilio_number = "7328565344"

    @client = Twilio::REST::Client.new sid, token

    @client.account.sms.messages.create(
      :from => "+1#{twilio_number}",
      :to => sender,
      :body => "Thanks for sharing what you love about Kate =)"
    )
  end
  
end