class AddHashToGuest < ActiveRecord::Migration
  def change
    add_column :guests, :strHash, :String
  end
end
