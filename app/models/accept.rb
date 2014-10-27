class Accept < ActiveRecord::Base
  belongs_to :sharer, class_name: 'User'
  belongs_to :sharee, class_name: 'User'

  has_many :notifications, dependent: :destroy

  after_commit :create_notification, on: :create

  def create_notification
    subject = "#{sharer.name} SUBJECT"
    body = "#{sharer.name} (#{sharer.email}) BODY."
    sharee.notify(subject, body, self)
  end
end
