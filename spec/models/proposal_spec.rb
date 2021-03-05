require 'rails_helper'

RSpec.describe Proposal, type: :model do
  describe "associations" do
    it { should belong_to(:job_candidate).class_name('JobCandidate') }
  end
end
