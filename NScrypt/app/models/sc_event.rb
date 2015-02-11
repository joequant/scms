class ScEvent < ActiveRecord::Base
  belongs_to :code;
  has_many :schedules;
  has_many :sc_event_run;
end
