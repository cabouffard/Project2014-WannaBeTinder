class PublicUserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :locale, :street, :city,
    :state, :country, :profession, :work_at, :picture, :email, :distance_to_text
end
