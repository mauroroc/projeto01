class CompaniesController < ApplicationController
    #before_action :authenticate_employee!
    def index
        @companies = Company.all
    end

    def edit
        @company = current_employee.company
    end

    def update
        @company = current_employee.company
        if @company.update(company_params)
            redirect_to @company
        else
            render :edit
        end
    end

    def show
        @company = Company.find(params[:id])
        if current_employee
            @admin = current_employee.admin                
        else
            @admin = false
        end            
    end

    def jobs
        company = Company.find(params[:id])
        @jobs = Job.where(company: company, status: true)        
    end

    private
        def company_params
            params.require(:company).permit(:name, :logo, :cep, :address, :address_number, :address_door, :city,
                                            :state, :cnpj, :url, :linkedin)
        end

end