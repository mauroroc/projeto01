require 'rails_helper'

RSpec.describe Company, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe "associations" do
    it{ is_expected.to have_many(:employee) }
    it{ is_expected.to have_many(:job) }
  end
end
