class Attendance < ApplicationRecord
  belongs_to :event
  belongs_to :user

  after_create :attendance_send

  def attendance_send
    event = self.event
    event_admin = event.event_admin
    UserMailer.attendance_email(event_admin, event).deliver_now
  end
end
