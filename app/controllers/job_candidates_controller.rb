class JobCandidatesController < ApplicationController
    before_action :authenticate_any

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
        @proposal = @offer.proposal      
    end

    def edit
        @offer = JobCandidate.find(params[:id])          
    end

    def update        
        @offer = JobCandidate.find(params[:id]) 
        @offer.update_attribute(:motive, decline_params[:motive])
        @offer.update_attribute(:message, decline_params[:message])
        @offer.declined_status
        redirect_to job_candidates_path
    end

    private
        def decline_params
            params.require(:job_candidate).permit(:motive, :message)            
        end
    
end