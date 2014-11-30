class MessagesController < ApplicationController
  def create
  end
  
  def index
    @messages = Message.all
    
    puts "hello world!"
    
    render :index
  end
  
  def destroy
  end
end
