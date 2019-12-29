class Attendance < ApplicationRecord
  validates_presence_of :time, :user_id, :registrar_id
end
