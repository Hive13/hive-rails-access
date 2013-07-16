class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :fname
      t.string :lname
      t.string :email
      t.string :phone
      t.text :interests
      t.datetime :date_in
      t.datetime :date_out
      t.boolean :badgeprinted
      t.timestamps
    end
  end
end
