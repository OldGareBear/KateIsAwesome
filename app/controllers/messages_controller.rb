class MessagesController < ApplicationController
  def index
    # @messages = Message.order(created_at: :desc).page(params[:page])
    @messages = Message.order(created_at: :desc).page(params[:page]).per_page(10)
    
    render :index
  end
  
  def destroy
  end
end
