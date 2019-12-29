require 'rails_helper'

RSpec.describe Attendance, type: :model do
  it { should validate_presence_of(:time) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:registrar_id) }
end
