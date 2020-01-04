class Account < ApplicationRecord
  resourcify
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  validates :name, presence: true
  validates :subdomain,
            exclusion: { in: %w[www admin], message: "%{value} is reserved" },
            presence: true,
            uniqueness: true

  has_one :owner_membership, -> { where(role: 'owner') }, class_name: 'Membership'
  has_one :owner, through: :owner_membership, source: :user, class_name: 'User'

  before_save :sanitize_subdomain
  before_create :set_admin

  accepts_nested_attributes_for :owner

  def sanitize_subdomain
    self.subdomain = subdomain.parameterize
  end

  def set_admin
    self.owner.add_role :admin, self
  end

end
