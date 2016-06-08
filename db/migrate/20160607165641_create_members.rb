class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |table|
      table.integer :user_id, null: false
      table.integer :meetup_id, null: false
      table.boolean :creator, null: false, default: false
    end

    add_index :members, [:user_id, :meetup_id], unique: true
  end
end
