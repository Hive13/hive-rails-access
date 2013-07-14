class AddYubikeyToMember < ActiveRecord::Migration
  def change
    add_column :members, :yubico, :string
    add_column :members, :is_admin, :boolean
    add_column :members, :is_lockedout, :boolean
    add_column :members, :is_private, :boolean
  end
end
