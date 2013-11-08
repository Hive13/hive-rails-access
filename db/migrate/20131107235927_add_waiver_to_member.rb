class AddWaiverToMember < ActiveRecord::Migration
  def change
    add_column :members, :waiver, :string
  end
end
