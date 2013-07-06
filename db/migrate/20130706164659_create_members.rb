class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :fname
      t.string :lname
      t.string :phone
      t.string :accesscard
      t.string :fsqtoken
      t.string :fbtoken
      t.string :twitoken

      t.timestamps
    end
  end
end
