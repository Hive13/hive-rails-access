class AddHandleToGuests < ActiveRecord::Migration
  def change
    add_column :guests, :handle, :string
  end
end
