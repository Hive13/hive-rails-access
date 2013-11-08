class AddHiveappToMember < ActiveRecord::Migration
  def change
    add_column :members, :hiveapp, :string
  end
end
