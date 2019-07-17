class Appointment < ApplicationRecord
  belongs_to :schedule

  validates_presence_of :start_date, :end_date, :schedule_id
end
