class PrivateUserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :locale, :street, :city,
    :state, :country, :profession, :work_at, :picture, :email, :latitude,
    :longitude, :authentication_token
end
