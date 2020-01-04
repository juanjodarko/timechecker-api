class Attendance < ApplicationRecord
  belongs_to :user
  validates_presence_of :time, :user_id, :registrar_id

end
