class Right < ActiveRecord::Base
  belongs_to :holder_user, :class_name => 'User', :foreign_key => 'holder_user_id'
  belongs_to :grantor_user, :class_name => 'User', :foreign_key => 'grantor_user_id'
  belongs_to :contract
end
