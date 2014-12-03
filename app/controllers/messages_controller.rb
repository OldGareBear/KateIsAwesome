class MessagesController < ApplicationController
  def index
    # @messages = Message.order(created_at: :desc).page(params[:page])
    @messages = Message.order(created_at: :desc).page(params[:page])
    
    render :index
  end
  
  def destroy
  end
end
