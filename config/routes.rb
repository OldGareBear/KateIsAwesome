Rails.application.routes.draw do
  root to: "static_pages#home"
  
  post 'twilio/process_sms' => 'twilio#process_sms'
end
