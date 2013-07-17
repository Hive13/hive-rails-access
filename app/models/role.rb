class Role < ActiveRecord::Base
  attr_accessible :member_id, :name
  belongs_to :member
end
