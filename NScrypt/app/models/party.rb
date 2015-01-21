class Party < ActiveRecord::Base
  belongs_to :person
  belongs_to :contract
  belongs_to :role
end
