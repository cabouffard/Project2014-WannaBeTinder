class ConversationController < PublicController
  def new
    @conversation = Conversation.new
    @conversations = Conversation.order("created_at DESC")
  end

  def index
    @conversations = Conversation.order("created_at DESC")
  end

  def create
      @message = conversation.new
      @message.assign_attributes(message_params)

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

