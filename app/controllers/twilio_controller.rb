require 'twilio-ruby'

class TwilioController < ApplicationController
  include Webhookable
  
  after_filter :set_header
  
  skip_before_action :verify_authenticity_token
  
  def process_sms(message)
    @body = message["Body"]
    @sender = message["From"]
    @city = message["FromCity"]
    
    response = Twilio::TwiML::Response.new do |resp|
      resp.Text "Thanks for telling us what you love about Kate!."
    end
    
    render_twiml response
  end
end
