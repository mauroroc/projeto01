class Company < ApplicationRecord
    has_many :employee
    has_many :job

    def updateAdm!(employee)
        employee.admin = true
    end
end
