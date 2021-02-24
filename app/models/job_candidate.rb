class JobCandidate < ApplicationRecord
  belongs_to :job
  belongs_to :candidate

  enum status: { 'Pendente de Avaliação': 0, 'Candidato Declinado': 1, 'Proposta Feita': 2, 'Proposta Recusada':3, 'Proposta Aceita': 4  }
end
