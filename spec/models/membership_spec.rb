require 'rails_helper'

RSpec.describe Membership, type: :model do
  it { belong_to(:account) }
  it { belong_to(:user) }
  it { validate_presence_of(:account) }
  it { validate_presence_of(:role) }
end
