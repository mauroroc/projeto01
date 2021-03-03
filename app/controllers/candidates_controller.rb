class CandidatesController < ApplicationController
    before_action :authenticate_candidate!
    
    def show        
        @candidate = current_candidate
    end
end