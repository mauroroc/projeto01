require 'rails_helper'

feature 'Employee fill company information' do
    scenario 'page is correct' do
        company = Company.create!(domain: 'xyz.com.br')
        account = Employee.create!(email: 'mauro@xyz.com.br', password: '123456', company: company, admin: true)
        login_as account, :scope => :employee

        visit root_path
        click_on 'Minha Empresa'
        
        expect(page).to have_content('Dados da Empresa')
    end

    scenario 'successfully' do        
        company = Company.create!(domain: 'xyz.com.br')
        account = Employee.create!(email: 'mauro@xyz.com.br', password: '123456', company: company, admin: true)
        login_as account, :scope => :employee

        visit root_path
        click_on 'Minha Empresa'        
        click_on 'Editar Empresa'
        fill_in 'Nome', with: 'XYZ Empreendimentos'        
        fill_in 'CEP', with: '40.000-000'
        fill_in 'Logradouro', with: 'Av. Teste'
        fill_in 'Número', with: '90'
        fill_in 'Complemento', with: 'Casa 27'
        fill_in 'Bairro', with: 'Centro'
        fill_in 'Cidade', with: 'Salvador'
        fill_in 'Estado', with: 'Bahia'
        fill_in 'CNPJ', with: '01.234.567/0001-89'
        fill_in 'Site', with: 'www.xyz.com.br'
        fill_in 'Linkedin', with: 'www.linkedin.com/xyz'        
        click_on 'Atualizar Empresa'

        expect(current_path).to eq(company_path(Company.last))
        expect(page).to have_content('XYZ Empreendimentos')
        expect(page).to have_content('01.234.567/0001-89')        
    end

    scenario 'employee is not administrator' do        
        company = Company.create!(domain: 'xyz.com.br')
        admin_account = Employee.create!(email: 'mauro@xyz.com.br', password: '123456', company: company, admin: false)
        account = Employee.create!(email: 'teste@xyz.com.br', password: '123456', company: company, admin: false)
        login_as account, :scope => :employee

        visit root_path
        click_on 'Minha Empresa'
        
        expect(page).not_to have_content('Editar Empresa')       
    end
end