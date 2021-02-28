class Company < ApplicationRecord
    has_many :employee
    has_many :job
    has_one_attached :image        

    def updateAdm!(employee)
        employee.admin = true
    end

    def self.search(search)       
        @result_search = Company.where('name LIKE ?', "%#{search}%")                 
    end
end
