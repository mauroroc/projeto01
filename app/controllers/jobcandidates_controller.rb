class JobcandidatesController < ApplicationController
    def index
        if current_employee                
            @offers = JobCandidate.all
        else
            if current_candidate
                @offers = JobCandidate.where(candidate: current_candidate)
            else
                @offers = JobCandidate.all
            end
        end
    end

    def show
        @offer = JobCandidate.find(params[:id])
        @job = @offer.job
        @candidate = @offer.candidate
    end
end