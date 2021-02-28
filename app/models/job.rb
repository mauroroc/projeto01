class Job < ApplicationRecord
    belongs_to :company    
    has_many :jobcandidate
    before_validation :ensure_change_status

    enum salary: { "Não Definido": 0, "Abaixo de R$ 5.000": 1, "Entre R$ 5.000 e R$ 10.000": 2, "Acima de R$ 10.000": 3 }
    enum stage: { "Júnior": 0, "Pleno": 1, "Sênior": 2 }
    enum status: { Ativo: true, Inativo: false }

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
