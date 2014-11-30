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
    
    response = Twilio::TwiML::Response.new do |resp|
      resp.Text "Thanks for telling us what you love about Kate!."
    end
    
    Message.create!(body: body, from: sender, city: city, state: state)
    #
    # thanks(sender)
    
    SMSLogger.log_text_message body, city
  end

  protected

  # def thanks(sender)
  #   sid = ENV["TWILIO_SID"]
  #   token = ENV["TWILIO_AUTH_TOKEN"]
  #   twilio_number = "7328565344"
  #
  #   @client = Twilio::REST::Client.new sid, token
  #
  #   @client.account.sms.messages.create(
  #     :from => "+1#{twilio_number}"),
  #     :to => sender
  #     :body => "Thanks for sharing what you love about Kate =)"
  #   )
  # end
end