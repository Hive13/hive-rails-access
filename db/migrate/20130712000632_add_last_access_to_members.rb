class AddLastAccessToMembers < ActiveRecord::Migration
  def change
      add_column :members, :last_access, :datetime
  end
end
