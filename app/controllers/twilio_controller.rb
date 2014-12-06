require 'twilio-ruby'

class TwilioController < ApplicationController
  include Webhookable
  
  after_filter :set_header
  
  skip_before_action :verify_authenticity_token
  
  def process_sms
    # grab sms params
    body = params["Body"]
    sender = params["From"]
    city = params["FromCity"]
    state = params["FromState"]
    signature = nil
    
    # check for signature
    if body =~ /\*(\w+(\s|$))+/
      # grab the signature
      signature = body.match(/\*(\w+(\s|$))+/).to_s[1, -1]
      # chop off the signature
      body.sub!(/\*(\w+(\s|$))+/, "")
    end 
   
    # check to see if the body is just a like
    if body.to_i > 0
      process_like(body.to_i, sender)
      return
    end
    
    save_message_and_admirer(sender, signature, body, city, state)
    
    # thank the sender
    response = Twilio::TwiML::Response.new do |resp|
      resp.Text "Thanks for telling us what you love about Kate!."
    end

    thanks(sender)
    
    redirect_to root_url
  end

  protected
  
  def process_like(id, sender)
    message = Message.find(id)
    like = Like.new(message_id: id, admirer_id: Admirer.find_by_phone_number(sender).id)
    
    return unless like && message
    like.save!
  end
  
  def save_message_and_admirer(sender, signature, body, city, state)
    puts "~~~~sender being processed~~~~" # debugging
    
    admirer = Admirer.find_by_phone_number(sender)
  
    p admirer
    
    if admirer && signature.nil? || admirer && signature == admirer.name
      p "we can't update an admirer without a new signature"
    elsif admirer && signature 
      p "allow for adding/changing names"
      p signature
      admirer.update(name: signature)
    else
      p "a new admirer needs to be created"
      p signature
      admirer = Admirer.new(name: signature, phone_number: sender)
      admirer.save!
    end
    
    message = Message.new(body: body, admirer_id: admirer.id, city: city, state: state)
    message.save!
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