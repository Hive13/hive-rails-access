require 'open-uri'

class Member < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :authy_authenticatable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :confirmable, :lockable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :authy_id, :last_sign_in_with_authy, :email, :password, :password_confirmation, :remember_me, :is_lockedout, :is_admin, :is_private, :yubico
  attr_accessible :accesscard, :email, :fbtoken, :fname, :fsqtoken, :lname, :phone, :twitoken, :handle, :last_access, :image, :MemberType

  mount_uploader :waiver, WaiverUploader
  mount_uploader :hiveapp, HiveappUploader

  mount_uploader :image, DoorimageUploader

  has_many :roles

  def picture_from_url(url)
      self.remote_image_url = url
  end

  def has_role? r
    roles.each do |member_role|
      return true if member_role.name == r
    end
    return false
  end



end
