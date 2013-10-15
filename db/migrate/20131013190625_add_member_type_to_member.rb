class AddMemberTypeToMember < ActiveRecord::Migration
  def change
    add_column :members, :MemberType, :integer
  end
end
