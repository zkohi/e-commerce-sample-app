require 'rails_helper'

RSpec.describe Admin, type: :model do
  context "has a valid factory" do
    it { expect(build(:admin)).to be_valid }
  end
end
