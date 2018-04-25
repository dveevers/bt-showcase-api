require 'rails_helper'

RSpec.describe Message, type: :model do
  it { should validate_presence_of(:channel) }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:created_at) }
  it { should validate_presence_of(:created_by) }
  it { should validate_presence_of(:direction) }
end
