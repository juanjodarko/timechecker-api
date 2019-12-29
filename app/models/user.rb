class User < ApplicationRecord
  has_secure_password
  has_many :attendances, foreign_key: :user_id
  has_many :attendance_registrations, foreign_key: :registrar_id

  validates_presence_of :first_name, :last_name, :email, :password_digest
end
