require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validates' do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_presence_of(:password) }
  end

  describe 'associations' do
    it { should have_many(:videos) }
  end
end
