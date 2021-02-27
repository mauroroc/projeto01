class Job < ApplicationRecord
    belongs_to :company    
    has_many :jobcandidate
    before_validation :ensure_change_status

    enum salary: { NaoDefinido: 0, Abaixo_de_5000: 1, Entre_5000_e_10000: 2, Acima_de_10000: 3 }
    enum stage: { Junior: 0, Pleno: 1, Senior: 2 }
    enum status: { Ativo: true, Inativo: false }

    def self.search(search)        
        @result_search = Job.where('title LIKE ?', "%#{search}%")                
    end    

    private
        def ensure_change_status                     
            self.status = true
        end
end
