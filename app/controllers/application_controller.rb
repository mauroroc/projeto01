require 'candidate_sanitizer'

class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    protected
  
    def devise_parameter_sanitizer
      if resource_class == Candidate
        Candidate::ParameterSanitizer.new(Candidate, :candidate, params)
      else
        super # Use the default one
      end
    end
end
