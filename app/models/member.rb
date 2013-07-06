class Member < ActiveRecord::Base
  attr_accessible :accesscard, :email, :fbtoken, :fname, :fsqtoken, :lname, :phone, :twitoken
end
