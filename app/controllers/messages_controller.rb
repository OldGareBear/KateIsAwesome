class MessagesController < ApplicationController
  def create
  end
  
  def index
    @messages = Message.all
    
    render :index
  end
  
  def destroy
  end
end
