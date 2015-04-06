class DebugRun < ActiveRecord::Base
  belongs_to :code
  belongs_to :user
end
