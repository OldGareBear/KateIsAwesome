class MessagesController < ApplicationController
  def index
    @messages = Message.order(created_at: :desc).page(params[:page]).per_page(10)
    @app_key = ENV['PUSHER_KEY']
    @buttsit = image_path("buttsit.png") # not making pusher live yet
    
    render :index
  end
  
  def destroy
  end
end
