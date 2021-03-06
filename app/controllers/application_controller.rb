class ApplicationController < ActionController::Base    
    before_action :configure_permitted_parameters, if: :devise_controller?

    def authenticate_any
      if !current_candidate && !current_employee
          redirect_to root_path
      end
    end

    protected
    def configure_permitted_parameters
      if resource_class == Candidate        
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :cpf, :phone, :bio, :email, :password])
        devise_parameter_sanitizer.permit(:account_update, keys: [:name, :cpf, :phone, :bio, :email, :password])                    
      end
    end
end
