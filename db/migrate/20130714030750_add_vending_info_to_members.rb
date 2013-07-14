class AddVendingInfoToMembers < ActiveRecord::Migration
  def change
    add_column :members, :vend_credits, :integer
    add_column :members, :vend_total, :integer
  end
end
