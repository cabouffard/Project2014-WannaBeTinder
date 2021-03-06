# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string(255)      not null
#  last_name              :string(255)      not null
#  street                 :string(255)
#  city                   :string(255)
#  state                  :string(255)
#  country                :string(255)
#  profession             :string(255)
#  work_at                :string(255)
#  picture                :string(255)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  admin                  :boolean          default(FALSE), not null
#  locale                 :string(255)      default("en")
#  created_at             :datetime
#  updated_at             :datetime
#  deleted_at             :datetime
#  latitude               :float
#  longitude              :float
#  denied_users           :string(255)      default([]), is an Array
#  contacted_users        :string(255)      default([]), is an Array
#  authentication_token   :string(255)
#
# Indexes
#
#  index_users_on_authentication_token    (authentication_token)
#  index_users_on_confirmation_token      (confirmation_token) UNIQUE
#  index_users_on_deleted_at              (deleted_at)
#  index_users_on_email_and_deleted_at    (email,deleted_at) UNIQUE
#  index_users_on_latitude_and_longitude  (latitude,longitude)
#  index_users_on_reset_password_token    (reset_password_token) UNIQUE
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
