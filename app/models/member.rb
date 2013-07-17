require 'open-uri'

class Member < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :token_authenticatable, :confirmable, :lockable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :is_lockedout, :is_admin, :is_private, :yubico
  attr_accessible :accesscard, :email, :fbtoken, :fname, :fsqtoken, :lname, :phone, :twitoken, :handle, :last_access

  attr_accessible :avatar, :avatar_file_name, :avatar_content_type, :avatar_file_size, :avatar_updated_at
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"

  has_many :roles

  def picture_from_url(url)
      self.avatar= open(url)
  end

  def has_role? r
    roles.each do |member_role|
      return true if member_role.name == r
    end
    return false
  end
end
