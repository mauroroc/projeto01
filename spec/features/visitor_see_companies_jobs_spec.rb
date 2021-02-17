require 'rails_helper'

feature 'Visitor see companies and jobs' do
    scenario 'page is correct' do        
        company = Company.create!(domain: 'xyz.com.br', name:'XYZ Empreendimentos', logo: 'logo.png', cep: '40.000-000',
                                address: 'Av. Teste', address_number: '90', address_door: 'casa 27', district: 'Centro',
                                cnpj: '01.234.567/0001-89', url: 'www.xyz.com.br', linkedin: 'www.linkedin.com/xyz')
        account = Account.create!(email: 'mauro@xyz.com.br', password: '123456', company: company, admin: false)
        job = Job.create!(title: 'FullStack Remoto', description: 'Conhecimento em Ruby on Rails e desejável em React', 
                          salary: 'Entre R$ 2.500 e R$ 5.000', stage: 'Júnior', need: 'Nível superior', valid: '20/06/2021',
                          quantity: 10, company: company, account: account, status: true)

        visit root_path
        expect(page).to have_content('xyz.com.br')
        expect(page).to have_content('FullStack Remoto')                  
    end

    scenario 'not see a disable or not valid job' do        
        company = Company.create!(domain: 'xyz.com.br', name:'XYZ Empreendimentos', logo: 'logo.png', cep: '40.000-000',
                                address: 'Av. Teste', address_number: '90', address_door: 'casa 27', district: 'Centro',
                                cnpj: '01.234.567/0001-89', url: 'www.xyz.com.br', linkedin: 'www.linkedin.com/xyz')
        account = Account.create!(email: 'mauro@xyz.com.br', password: '123456', company: company, admin: false)
        job = Job.create!(title: 'FullStack Remoto', description: 'Conhecimento em Ruby on Rails e desejável em React', 
                          salary: 'Entre R$ 2.500 e R$ 5.000', stage: 'Júnior', need: 'Nível superior', valid: '20/06/2021',
                          quantity: 10, company: company, account: account, status: false)
        job2 = Job.create!(title: 'FullStack Presencial', description: 'Conhecimento em Ruby on Rails e desejável em React', 
                          salary: 'Entre R$ 2.500 e R$ 5.000', stage: 'Júnior', need: 'Nível superior', valid: '20/06/2020',
                          quantity: 10, company: company, account: account, status: true)
        job3 = Job.create!(title: 'FrontEnd', description: 'Conhecimento em Ruby on Rails e desejável em React', 
                          salary: 'Entre R$ 2.500 e R$ 5.000', stage: 'Júnior', need: 'Nível superior', valid: '20/06/2021',
                          quantity: 10, company: company, account: account, status: true)                 

        visit root_path
        expect(page).not_to have_content('FullStack Presencial')
        expect(page).not_to have_content('FullStack Remoto')                  
        expect(page).to have_content('FrontEnd')
    end

    scenario 'search company' do        
        company = Company.create!(domain: 'xyz.com.br', name:'XYZ Empreendimentos', logo: 'logo.png', cep: '40.000-000',
                                address: 'Av. Teste', address_number: '90', address_door: 'casa 27', district: 'Centro',
                                cnpj: '01.234.567/0001-89', url: 'www.xyz.com.br', linkedin: 'www.linkedin.com/xyz')
        account = Account.create!(email: 'mauro@xyz.com.br', password: '123456', company: company, admin: false)
        job = Job.create!(title: 'FullStack Remoto', description: 'Conhecimento em Ruby on Rails e desejável em React', 
                          salary: 'Entre R$ 2.500 e R$ 5.000', stage: 'Júnior', need: 'Nível superior', valid: '20/06/2021',
                          quantity: 10, company: company, account: account, status: true)

        visit root_path
        fill_in 'Busca', with: 'XYZ'
        click_on 'Buscar'
                        
        expect(page).to have_content('XYZ Empreendimentos')
        expect(page).to have_content('Ver vagas')                
    end

    scenario 'search job' do        
        company = Company.create!(domain: 'xyz.com.br', name:'XYZ Empreendimentos', logo: 'logo.png', cep: '40.000-000',
                                address: 'Av. Teste', address_number: '90', address_door: 'casa 27', district: 'Centro',
                                cnpj: '01.234.567/0001-89', url: 'www.xyz.com.br', linkedin: 'www.linkedin.com/xyz')
        account = Account.create!(email: 'mauro@xyz.com.br', password: '123456', company: company, admin: false)
        job = Job.create!(title: 'FullStack Remoto', description: 'Conhecimento em Ruby on Rails e desejável em React', 
                          salary: 'Entre R$ 2.500 e R$ 5.000', stage: 'Júnior', need: 'Nível superior', valid: '20/06/2021',
                          quantity: 10, company: company, account: account, status: true)

        visit root_path
        fill_in 'Busca', with: 'FullStack'
        click_on 'Buscar'
                        
        expect(page).to have_content('XYZ Empreendimentos')
        expect(page).to have_content('FullStack Remoto')                
    end
end