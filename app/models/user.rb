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

class User < ActiveRecord::Base
  acts_as_token_authenticatable
  acts_as_paranoid
  validates_as_paranoid

  mount_uploader :picture, AvatarUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :async, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_conversations
  has_many :conversations, through: :user_conversations
  has_many :messages, through: :conversations

  # Basic information
  validates :first_name, :last_name,
            presence: true, length: { maximum: 60 }
  validates :email, presence: true, email: true
  validates :profession, presence: true
  validates :city, :state, :country, presence: true, unless: :validate_password?

  validates :password, length: { minimum: 8 }, if: :validate_password?

  geocoded_by :current_sign_in_ip   # can also be an IP address

  reverse_geocoded_by :latitude, :longitude do |obj, results|
    if geo = results.first
      obj.street  = geo.street_address
      obj.state   = geo.state
      obj.city    = geo.city
      obj.country = geo.country
    end
  end
  # after_validation :geocode         # auto-fetch coordinates
  before_validation :reverse_geocode, if: :location_has_changed?

  # TODO: This has to be fixed
  # has_secure_password
  # def validate_password?
  #   validate_password || new_record?
  # end
  #
  def location_has_changed?
    latitude_changed? || longitude_changed?
  end

  def validate_password?
    new_record?
  end

  def full_name
    "#{first_name} #{last_name}"
  end
  alias :name :full_name

  def full_name_reversed
    "#{last_name}, #{first_name}"
  end

  def address
    [street, city, state, country].compact.join(', ')
  end

  def has_gps_location?
    latitude? && longitude?
  end

  def self.professions
    ["entrepreneur", "designer", "developper"]
  end
end
