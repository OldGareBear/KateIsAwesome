Rails.application.routes.draw do
  root to: "messages#index"
  
  resources :messages
  
  post '/twilio/process_sms' => 'twilio#process_sms'
end
