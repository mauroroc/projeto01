class SearchesController < ApplicationController
    def show
        @query = params[:query]
        @item = params[:item]
        if @item == "Empresa"
            @jobs = Job.searchCompany(@query)
        else
            @jobs = Job.search(@query)
        end
    end
end