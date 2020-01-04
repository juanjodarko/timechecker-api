class User < ApplicationRecord
  rolify
  has_secure_password
  has_many :attendances, foreign_key: :user_id
  has_many :attendance_registrations, foreign_key: :registrar_id

  has_many :memberships, dependent: :destroy
  has_many :accounts, through: :memberships

  scope :checkins, -> { joins(:attendances).where(attendances: { type: 'Checkin' }) }
  scope :checkouts, -> { joins(:attendances).where(attendances: { type: 'Checkout' }) }

  after_create :assign_default_role

  validates_presence_of :first_name, :last_name, :email, :password_digest

  def full_name
    "#{first_name} #{last_name}"
  end

  def has_checkedin_today?
    attendances.where(type: 'Checkin', time: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).count > 0
  end

  def has_checkedout_today?
    attendances.where(type: 'Checkout', time: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).count > 0
  end


  def as_json(options={})
    super(only: [ :id, :email, :first_name, :last_name ],
          methods: [ :full_name, :has_checkedin_today?, :has_checkedout_today? ],
          include: {
            roles: { only: [:name] },
            attendances: { only: [:time, :type] }
          })
  end

  private

  def assign_default_role
    self.add_role(:employee) if self.roles.blank?
  end
end
