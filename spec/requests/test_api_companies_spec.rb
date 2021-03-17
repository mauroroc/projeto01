require 'rails_helper'

describe 'API' do
    context 'GET Companies' do  
        it 'shoul render company info' do
            company = Company.create!(domain: 'xyz', name:'XYZ Empreendimentos', cep: '40.000-000',
                                    address: 'Av. Teste', address_number: '90', address_door: 'casa 27', district: 'Centro',
                                    cnpj: '01.234.567/0001-89', url: 'www.xyz.com.br', linkedin: 'www.linkedin.com/xyz')        
            get "/api/v1/companies/#{company.id}"

            expect(response).to have_http_status(200)
        end
    end
end
