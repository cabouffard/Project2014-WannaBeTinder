# == Schema Information
#
# Table name: conversations
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  deleted_at :datetime
#

class Conversation < ActiveRecord::Base
  has_many :user_conversations
  has_many :users, through: :user_conversations
  has_many :messages, dependent: :delete_all

end

