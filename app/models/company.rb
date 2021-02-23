class Company < ApplicationRecord
    has_many :employee
    has_many :job

    def updateAdm!(employee)
        employee.admin = true
    end

    def self.search(search)
        if search != ""                     
            @result_search = Company.where(name: search)
        else
            @result_search = Company.all
        end
    end
end
