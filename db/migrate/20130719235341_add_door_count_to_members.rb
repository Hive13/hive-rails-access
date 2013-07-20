class AddDoorCountToMembers < ActiveRecord::Migration
  def change
    add_column :members, :door_count, :integer
  end
end
