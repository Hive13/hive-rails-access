class Guest < ActiveRecord::Base
  attr_accessible :badgeprinted, :date_in, :date_out, :email, :fname, :interests, :lname, :phone, :handle
  validates :fname, presence: true
  validates :lname, presence: true
end
