# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

if !User.where(email: "cabouffard@gmail.com").exists?
  user = User.create(first_name: "Charles-André", last_name: "Bouffard", email: "cabouffard@gmail.com", password: "charles123@", profession: User::PROFESSIONS[2], confirmed_at: DateTime.now, admin: true)
  user.save()
end

if !User.where(email: "nault.alex@gmail.com").exists?
  user = User.create(first_name: "Alex", last_name: "Nault", email: "nault.alex@gmail.com", password: "alex123@", profession: User::PROFESSION[1], confirmed_at: DateTime.now, admin: true)
  user.save()
end

if !User.where(email: "jp.goulet17@gmail.com").exists?
  user = User.create(first_name: "Jean-Philippe", last_name: "Goulet", email: "jp.goulet17@gmail.com", password: "goulet123@", profession: User::PROFESSIONS[0], confirmed_at: DateTime.now, admin: true)
  user.save()
end
