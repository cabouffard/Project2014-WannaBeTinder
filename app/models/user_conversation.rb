# == Schema Information
#
# Table name: user_conversations
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  conversation_id :integer
#  read            :boolean          default(FALSE)
#  created_at      :datetime
#  updated_at      :datetime
#  deleted_at      :datetime
#
# Indexes
#
#  index_user_conversations_on_conversation_id  (conversation_id)
#  index_user_conversations_on_user_id          (user_id)
#

class UserConversation < ActiveRecord::Base
  belongs_to :user
  belongs_to :conversation
  has_many :messages, through: :conversation

  accepts_nested_attributes_for :conversation

  delegate :users, to: :conversation

  before_create :create_user_conversations

  attr_accessor :to

  def set_recipient(user)
    @to = users.where.not(id: user.id).limit(1).first
    if @to.nil?
      @to = user
    end
  end

private

  def create_user_conversations
    return if to.blank?
    UserConversation.create user_id: to.id, conversation: conversation
  end
end
