class AddDoorimageAndDeleteBsFromMembers < ActiveRecord::Migration
  def change
    add_column :members, :image, :string
    remove_column :members, :checkin_picture_file_name
    remove_column :members, :checkin_picture_content_type
    remove_column :members, :checkin_picture_file_size
    remove_column :members, :checkin_picture_updated_at
    remove_column :members, :avatar_file_name
    remove_column :members, :avatar_content_type
    remove_column :members, :avatar_file_size
    remove_column :members, :avatar_updated_at
  end
end
