class ProposalsController < ApplicationController
    before_action :authenticate_any
    
    def new
        @proposal = Proposal.new
        @offer = JobCandidate.find(params[:offer])      
    end

    def create 
        job_candidate = JobCandidate.find(proposal_params[:job_candidate]) 
        update_params = proposal_params
        update_params[:job_candidate] = job_candidate
        @proposal = Proposal.new(update_params)
        if @proposal.save
            job_candidate.update_attribute(:status, 2)
            redirect_to job_candidates_path
        else
            render :new
        end        
    end

    def edit
        @offer = JobCandidate.find(params[:offer])    
        @proposal = @offer.proposal 
        @accept = params[:accept]      
    end

    def update     
        job_candidate = JobCandidate.find(proposal_update_params[:job_candidate]) 
        proposal = Proposal.find(params[:id]) 
        if proposal_update_params[:accept]
            job_candidate.update_attribute(:status, 4)           
            job_candidate.job.vaga_occupied                                
            redirect_to job_candidates_path  
        else
            if proposal_update_params[:decline]                
                proposal.update_attribute(:motive, proposal_update_params[:motive])
                job_candidate.update_attribute(:status, 3)
                redirect_to job_candidates_path
            else
                render :edit
            end
        end
    end

    private
        def proposal_params
            params.require(:proposal).permit(:salary_proposal, :message, :start_date, :job_candidate)            
        end 

        def proposal_update_params
            params.require(:proposal).permit(:motive, :accept, :decline, :job_candidate)            
        end      
end