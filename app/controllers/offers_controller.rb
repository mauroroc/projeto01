class OffersController < ApplicationController

    def make
        job = Job.find(params[:id])
        JobCandidate.create!(job: job, candidate: current_candidate, status: 0)
        redirect_to jobs_path
    end

    def decline        
        @offer = JobCandidate.find(params[:id])                  
    end

    def declined
        @offer = JobCandidate.find(params[:id]) 
        @offer.update_attribute(:motive, params[:motive])
        @offer.update_attribute(:message, params[:message])
        @offer.update_attribute(:status, 1)
        redirect_to jobcandidates_path
    end
    
    def proposal
        @offer = JobCandidate.find(params[:id])      
    end

    def sended
        @offer = JobCandidate.find(params[:id]) 
        @offer.update_attribute(:salary_proposal, params[:salary_proposal])
        @offer.update_attribute(:start_date, params[:start_date])
        @offer.update_attribute(:message, params[:message])
        @offer.update_attribute(:status, 2)
        redirect_to jobcandidates_path
    end

    def refuse
        @offer = JobCandidate.find(params[:id])         
    end

    def refused
        @offer = JobCandidate.find(params[:id]) 
        @offer.update_attribute(:motive, params[:motive])
        @offer.update_attribute(:status, 3)
        redirect_to jobcandidates_path
    end

    def accept
        @offer = JobCandidate.find(params[:id])         
    end

    def accepted
        @offer = JobCandidate.find(params[:id]) 
        @offer.update_attribute(:accept_date, params[:accept_date])
        @offer.update_attribute(:status, 4)
        redirect_to jobcandidates_path        
    end
end