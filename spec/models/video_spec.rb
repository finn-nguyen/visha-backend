require 'rails_helper'

RSpec.describe Video, type: :model do
  describe 'validates' do
    it { should validate_presence_of(:link) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end
end
