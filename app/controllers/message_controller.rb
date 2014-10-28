class MessageController < PublicController
  def new
    @comment = Message.new
    @comments = Message.order("created_at DESC")
  end

  def index
    @comments = Message.order("created_at DESC")
  end

  def create
      @message = Message.new
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

