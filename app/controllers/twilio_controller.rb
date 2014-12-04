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
    signature = nil
    
    # check for signature
    if body =~ /\*(\w+(\s|$))+/
      # grab the signature
      signature = body.match(/\*(\w+(\s|$))+/)[1, -1]
      # chop off the signature
      body.sub!(/\*(\w+(\s|$))+/, "")
    end 
   
    # check to see if the body is a vote
    if body.to_i > 0
      process_like(body.to_i, sender)
      return
    end
    
    process_sender(sender, signature)
    
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
  
  def process_sender(sender, signature)
    puts "~~~~sender being processed~~~~" # debugging
    admirer = Admirer.find_by_sender(sender)
    
    # if an admirer exists, only proceed if you are adding signature
    return if admirer && signature.nil?
    
    # allow for adding/changing names
    if admirer && signature
      admirer.update(name: signature)
    else
      # a new admirer needs to be created
      admirer = Admirer.new(name: signature, phone_number: sender)
      admirer.save!
    end
    
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