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

  attr_accessor :to
  before_create :create_user_conversations
end
