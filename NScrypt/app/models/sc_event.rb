class ScEvent < ActiveRecord::Base
  belongs_to :code;
  has_many :schedules;
end
