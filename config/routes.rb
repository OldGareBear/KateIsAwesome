Rails.application.routes.draw do
  root to: "messages#index"
  
  resources :messages, only: [:create, :destroy, :index]
  
  resources :likes, only: [:create, :destroy]
  
  get '/about', :to => 'static_pages#about'
  
  post '/twilio/process_sms' => 'twilio#process_sms'
end
