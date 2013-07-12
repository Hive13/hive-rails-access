class AddHandleToMembers < ActiveRecord::Migration
  def change
      add_column :members, :handle, :string
  end
end
