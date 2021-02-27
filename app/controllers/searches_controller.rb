class SearchesController < ApplicationController
    def show
        @query = params[:query]
        @item = params[:item]
        if @item == "Empresa"
            @companies = Company.search(@query)
        else
            @jobs = Job.search(@query)
        end
    end
end