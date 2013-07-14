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

  # For member checkin pictures...
  attr_accessible :checkin_picture
  has_attached_file :checkin_picture, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"

  def picture_from_url(url)
    self.checkin_picture = open(url)
  end

end
