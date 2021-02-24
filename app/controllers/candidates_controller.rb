class CandidatesController < ApplicationController
    def show        
        @candidate = current_candidate
    end
end