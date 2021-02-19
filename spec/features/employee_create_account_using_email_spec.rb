require 'rails_helper'

feature 'Employee create account using email' do
    scenario 'page is correct' do
        visit root_path

        expect(page).to have_content('Balcão de Empregos')
    end

    scenario 'successfully' do        
        company = Company.create!(domain: 'xyz')
        account = Employee.create!(email: 'mauro@xyz.com.br', password: '123456', company: company, admin: false)
        company.updateAdm!(account)
                
        expect(company).to be_valid
        expect(account).to be_valid
    end

    scenario 'company exists' do        
        company = Company.create!(domain: 'xyz')
        companyExists = Company.find_by(domain: 'xyz')
        account = Employee.create!(email: 'mauro@xyz.com.br', password: '123456', company: companyExists, admin: false)

        expect(Company.find_by(domain: 'xyz')).to eq(companyExists)        
        expect(account).to be_valid       
    end
end