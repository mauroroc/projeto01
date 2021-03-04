class JobCandidate < ApplicationRecord
  belongs_to :job
  belongs_to :candidate
  has_one :proposal

  enum status: { pending: 0, declined: 1, proposal: 2, refused:3, accepted: 4  }
end
