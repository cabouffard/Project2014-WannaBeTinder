# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

if !User.where(email: "cabouffard@gmail.com").exists?
  user = User.create(first_name: "Charles-André", last_name: "Bouffard", email: "cabouffard@gmail.com", password: "charles123@", confirmed_at: DateTime.now, admin: true)
  user.save(validate: false)
end
