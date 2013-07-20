class FixLastAccessMembers < ActiveRecord::Migration
  def up
      remove_column :members, :last_access
      add_column :members, :last_access, :datetime
  end

  def down
  end
end
