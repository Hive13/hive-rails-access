class AddStripeTokenToMembers < ActiveRecord::Migration
  def change
    add_column :members, :stripeToken, :string
  end
end
