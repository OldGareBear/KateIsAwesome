class MessagesController < ApplicationController
  def index
    @messages = Message.all
    
    render :index
  end
  
  def destroy
  end
end
