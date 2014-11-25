class UserConversationsController < ApplicationController
  def index
    @conversations = current_user.user_conversations
  end

  def show
    @conversation = Conversation.find params[:id]
    @conversation.set_recipient(current_user)
    @message = Message.new
    @message.conversation = @conversation
    @message.user = current_user
  end

  def update
    @conversation.update_attributes(user_conversation_params)
    @conversation.save!
  end

  def new
    @conversation = current_user.user_conversations.build
    @conversation.build_conversation.messages.build
  end

  def create
    @conversation = UserConversation.new(user_conversation_params)
    @conversation.user = current_user
    @conversation.conversation.messages.first.user = current_user
    @conversation.save!
    redirect_to user_conversation_path(current_user, @conversation)
  end

  def mark_as_read
    @conversation = UserConversation.find params[:id]
    @conversation.update_attributes :read => true
    redirect_to user_conversation_path(current_user, @conversation)
  end

  def mark_as_unread
    @conversation = UserConversation.find params[:id]
    @conversation.update_attributes :read => false
    redirect_to user_conversation_path(current_user, @conversation)
  end

  private

  def user_conversation_params
    params.require(:user_conversation).permit(:to, conversation_attributes: [:id, [messages_attributes: [:body, :id]]])
  end

end
