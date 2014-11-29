module Webhookable
extend ActiveSupport::Concern

  def set_header
    response.headers["Content-Type"] = "txt/xml"
  end
  
  def render_twiml(response)
    render text: response.text
  end
  
end