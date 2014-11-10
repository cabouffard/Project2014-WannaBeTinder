class MessagesController < ApplicationController
  def new
    @messages = Message.order("created_at DESC")
  end

  def index
    @messages = Message.order("created_at DESC")
  end

  def create
      @message = Message.new
      @message.assign_attributes(message_params)
      @message.conversation_id = 1
      @message.user = current_user
      @message.conversation.set_recipient(current_user)

      @conversation = @message.conversation
      @recipient = @message.conversation.to
      if @message.save
        flash.now[:success] = 'Your comment was successfully posted!'
      else
        flash.now[:error] = 'Your comment cannot be saved.'
      end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end

