class AddContactedUsersToUser < ActiveRecord::Migration
  def change
    add_column :users, :contacted_users, :string, array: true, default: '{}'
  end
end
