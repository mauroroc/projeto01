class Api::V1::CompaniesController < Api::V1::ApiController
    def show
        company = Company.find(params[:id])
        return render status: 404, 
                json: "{ msg: 'coupon not found' }" if company.nil?
        render json: company.as_json(only: [:name, :cnpj, :url],
                                    include: { 
                                                job: { only: :title }
                                        }), status: 200 
    end
end