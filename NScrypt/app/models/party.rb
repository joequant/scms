class Party < ActiveRecord::Base
  belongs_to :person
  belongs_to :code
  belongs_to :role
end
