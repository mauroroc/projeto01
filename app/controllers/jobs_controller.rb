class JobsController < ApplicationController    
    before_action :authenticate_employee!, except: [:show, :index]
    
    def index
        if current_employee
            @jobs = Job.all
        else    
            @jobs = Job.where(status: true)
        end
    end

    def show
        @job = Job.find(params[:id])
        if current_employee
            if current_employee.company == @job.company
              @logado = true
            else
              @logado = false
            end
        else
            @logado = false
        end        
    end
    
    def new
        @job = Job.new
        @cadastro = true
    end

    def create      
        update_params = job_params
        update_params[:company] = current_employee.company
        @job = Job.new(update_params)
        if @job.save
            redirect_to @job
        else
            render :new
        end
    end

    def edit
        @job = Job.find(params[:id])
        @cadastro = true
      end
    
    def update
        @job = Job.find(params[:id])

        if @job.update(job_update_params)
            redirect_to @job
        else
            render :edit
        end
    end

    def disable
        @job = Job.find(params[:id])
        @job.update_attribute(:status, false)        
        redirect_to jobs_path
    end    

    private
        def job_params
            params.require(:job).permit(:title, :description, :salary, :stage, :need, :expiration, :quantity, :company)            
        end 

        def job_update_params
            params.require(:job).permit(:title, :description, :salary, :stage, :need, :expiration, :quantity)            
        end        
end