Rails.application.routes.draw do
  root to: "static_pages#home"
  
  POST 'twilio/process_sms' => 'twilio#process_sms'
end
