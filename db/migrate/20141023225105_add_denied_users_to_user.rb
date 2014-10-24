class AddDeniedUsersToUser < ActiveRecord::Migration
  def change
      add_column :users, :denied_users, :string, array: true, default: '{}'
  end
end
