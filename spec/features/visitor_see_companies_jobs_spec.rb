require 'rails_helper'

feature 'Visitor see companies and jobs' do
    scenario 'page is correct' do        
        company = Company.create!(domain: 'xyz', name:'XYZ Empreendimentos', cep: '40.000-000',
                                address: 'Av. Teste', address_number: '90', address_door: 'casa 27', district: 'Centro',
                                cnpj: '01.234.567/0001-89', url: 'www.xyz.com.br', linkedin: 'www.linkedin.com/xyz')        
        job = Job.create!(title: 'FullStack Remoto', description: 'Conhecimento em Ruby on Rails e desejável em React', 
            salary: 1, stage: 1, need: 'Nível superior', expiration: '20/06/2021',
            quantity: 10, company: company, status: true)

        visit root_path
        click_on 'Empresas'
        click_on 'XYZ Empreendimentos'
        expect(page).to have_content('XYZ Empreendimentos')
        expect(page).to have_content('Dados da Empresa')                  
    end

    scenario 'not see a disable or not valid job' do        
        company = Company.create!(domain: 'xyz', name:'XYZ Empreendimentos', cep: '40.000-000',
                                address: 'Av. Teste', address_number: '90', address_door: 'casa 27', district: 'Centro',
                                cnpj: '01.234.567/0001-89', url: 'www.xyz.com.br', linkedin: 'www.linkedin.com/xyz')        
        job2 = Job.create!(title: 'FullStack Presencial', description: 'Conhecimento em Ruby on Rails e desejável em React', 
            salary: 1, stage: 1, need: 'Nível superior', expiration: '20/06/2020',
            quantity: 10, company: company, status: true)
        job3 = Job.create!(title: 'FrontEnd', description: 'Conhecimento em Ruby on Rails e desejável em React', 
            salary: 1, stage: 1, need: 'Nível superior', expiration: '20/06/2021',
            quantity: 10, company: company, status: true)                

        visit root_path
        click_on 'Vagas'
        expect(page).not_to have_content('FullStack Presencial')                         
        expect(page).to have_content('FrontEnd')
    end

    scenario 'search company' do        
        company = Company.create!(domain: 'xyz', name:'XYZ Empreendimentos', cep: '40.000-000',
                                address: 'Av. Teste', address_number: '90', address_door: 'casa 27', district: 'Centro',
                                cnpj: '01.234.567/0001-89', url: 'www.xyz.com.br', linkedin: 'www.linkedin.com/xyz')        
        job = Job.create!(title: 'FullStack Remoto', description: 'Conhecimento em Ruby on Rails e desejável em React', 
            salary: 1, stage: 1, need: 'Nível superior', expiration: '20/06/2021',
            quantity: 10, company: company, status: true)

        visit root_path
        fill_in 'Buscar por', with: 'XYZ Empreendimentos'
        select 'Empresa', from: 'Em'
        click_on 'Buscar'
                        
        expect(page).to have_content('FullStack Remoto')                     
    end

    scenario 'search job' do        
        company = Company.create!(domain: 'xyz', name:'XYZ Empreendimentos', cep: '40.000-000',
                                address: 'Av. Teste', address_number: '90', address_door: 'casa 27', district: 'Centro',
                                cnpj: '01.234.567/0001-89', url: 'www.xyz.com.br', linkedin: 'www.linkedin.com/xyz')        
        job = Job.create!(title: 'FullStack Remoto', description: 'Conhecimento em Ruby on Rails e desejável em React', 
            salary: 1, stage: 1, need: 'Nível superior', expiration: '20/06/2021',
            quantity: 10, company: company, status: true)

        visit root_path        
        fill_in 'Buscar por', with: 'FullStack Remoto'
        select 'Vagas', from: 'Em'
        click_on 'Buscar'
                                
        expect(page).to have_content('XYZ Empreendimentos')                
    end
end