class AddAttachmentCheckinPictureToMembers < ActiveRecord::Migration
  def self.up
    change_table :members do |t|
      t.attachment :checkin_picture
    end
  end

  def self.down
    drop_attached_file :members, :checkin_picture
  end
end
