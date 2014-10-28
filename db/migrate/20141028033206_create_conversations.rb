class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
