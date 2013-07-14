class AddVendEnabledToMembers < ActiveRecord::Migration
  def change
    add_column :members, :vend_enabled, :boolean
  end
end
