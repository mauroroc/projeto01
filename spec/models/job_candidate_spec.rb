require 'rails_helper'

RSpec.describe JobCandidate, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  describe "associations" do
    it { should belong_to(:candidate).class_name('Candidate') }
  end
end
