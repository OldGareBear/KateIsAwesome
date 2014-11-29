require 'twilio-ruby'

class TwilioController < ApplicationController
  include Webhookable
  
  after_filter :set_header
  
  skip_before_action :verify_authenticity_token
  
  def process_sms
    response = Twilio::TwiML::Response.new do |resp|
      resp.text "Thanks for telling us what you love about Kate! Please send the signature you would like to leave on your comment, or remain anonymous if you prefer =)"
    end
  end
  
  render_twiml response
end
