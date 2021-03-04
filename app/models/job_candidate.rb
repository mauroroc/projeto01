class JobCandidate < ApplicationRecord
  belongs_to :job
  belongs_to :candidate
  has_one :proposal

  enum status: { pending: 0, declined: 1, proposal: 2, refused:3, accepted: 4  }

  def proposal_status
    self.update_attribute(:status, 2)
  end

  def declined_status
    self.update_attribute(:status, 1)
  end

  def refused_status
    self.update_attribute(:status, 3)
  end  

  def accepted_status
    self.update_attribute(:status, 4)
  end

end
