require 'rails_helper'

RSpec.describe Message, type: :model do
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:channel) }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:created_at) }
  it { should validate_presence_of(:autor) }

end
