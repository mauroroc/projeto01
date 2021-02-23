class Candidate::ParameterSanitizer < Devise::ParameterSanitizer
    def initialize(*)
      super
      permit(:sign_up, keys: [:name, :cpf, :phone, :bio, :email, :password])
      permit(:account_update, keys: [:name, :cpf, :phone, :bio, :email, :password])                    
    end
  end