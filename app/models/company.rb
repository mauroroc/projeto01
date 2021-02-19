class Company < ApplicationRecord
    has_many :employee

    def updateAdm!(employee)
        employee.admin = true
    end
end
