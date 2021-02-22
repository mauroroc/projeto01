class SearchesController < ApplicationController
    def show
        @query = params[:query]
        @item = params[:item]
        if @item == "Empresa"
            @items = Company.search(@query)
        else
            @items = Job.search(@query)
        end
    end
end