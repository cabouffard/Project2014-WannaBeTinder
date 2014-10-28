# == Schema Information
#
# Table name: messages
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  conversation_id :integer
#  body            :text
#  created_at      :datetime
#  updated_at      :datetime
#  deleted_at      :datetime
#
# Indexes
#
#  index_messages_on_conversation_id  (conversation_id)
#  index_messages_on_user_id          (user_id)
#

class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :conversation

  validates :body, presence: true, length: { maximum: 200 }
end
