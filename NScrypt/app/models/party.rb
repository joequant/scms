class Party < ActiveRecord::Base
  belongs_to :user
  belongs_to :code
  belongs_to :role
end
