class OffersController < ApplicationController

    def make
        job = Job.find(params[:id])
        JobCandidate.create!(job: job, candidate: current_candidate, status: 0)
        redirect_to jobs_path
    end

    def decline        
        @offer = JobCandidate.find(params[:id])                  
      end
    
    def proposal
        @offer = JobCandidate.find(params[:id])        
    end

end