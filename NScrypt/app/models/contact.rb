class Contact < ActiveRecord::Base
  belongs_to :user, :class_name => 'User', :foreign_key => 'user_id'
  belongs_to :contact_user, :class_name => 'User', :foreign_key => 'contact_user_id'
end
