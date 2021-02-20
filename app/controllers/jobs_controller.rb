class JobsController < ApplicationController
    before_action :authenticate_employee!
    def index
        
    end
    
    def new
        @job = Job.new
    end

    def create
        @job = Job.new(job_params)
    end

    private
        def job_params
            params.require(:job).permit(:title, :description, :salary, :stage, :need, :valid, :quantity, :company, :status)
        end
            
end