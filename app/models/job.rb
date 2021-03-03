class Job < ApplicationRecord
    belongs_to :company    
    has_many :jobcandidate
    before_validation :ensure_change_status

    enum salary: { undefined: 0, under: 1, between: 2, above: 3 }
    enum stage: { junior: 0, full: 1, senior: 2 }
    enum status: { active: true, inactive: false }

    validates :title, presence: true
    validates :need, presence: true
    validates :expiration, presence: true
    validates :quantity, presence: true
    validates :description, presence: true

    def self.search(search)        
        @result_search = Job.where('title LIKE ?', "%#{search}%")                
    end    

    private
        def ensure_change_status                     
            self.status = true
        end
end
