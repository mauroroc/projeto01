class Job < ApplicationRecord
    belongs_to :company    
    before_validation :ensure_add_company

    enum salary: { NaoDefinido: 0, Abaixo_de_5000: 1, Entre_5000_e_10000: 2, Acima_de_10000: 3 }
    enum stage: { Junior: 0, Pleno: 1, Senior: 2 }

    private
        def ensure_add_company
            self.company = current_employee.company
            self.status = true
        end
end
