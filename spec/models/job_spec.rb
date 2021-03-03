require 'rails_helper'

RSpec.describe Job, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe "associations" do
    it { should belong_to(:company).class_name('Company') }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:need) }
    it { should validate_presence_of(:expiration) }
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:description) }    
  end

end
