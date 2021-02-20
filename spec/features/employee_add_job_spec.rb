require 'rails_helper'

feature 'Employee add job' do
    scenario 'page is correct' do        
        company = Company.create!(domain: 'xyz.com.br')
        account = Employee.create!(email: 'mauro@xyz.com.br', password: '123456', company: company, admin: false)
        login_as account, :scope => :employee

        visit root_path
        click_on 'Vagas'        

        expect(page).to have_content('Cadastrar Vaga')
    end

    scenario 'successfully' do        
        company = Company.create!(domain: 'xyz.com.br')
        account = Employee.create!(email: 'mauro@xyz.com.br', password: '123456', company: company, admin: false)
        login_as account, :scope => :employee

        visit root_path
        click_on 'Vagas'
        click_on 'Cadastrar Vaga'

        fill_in 'Titulo', with: 'FullStack Remoto'
        fill_in 'Descrição', with: 'Conhecimento em Ruby on Rails e desejável em React'
        fill_in 'Faixa Salarial', with: 'Entre R$ 2.500 e R$ 5.000'
        fill_in 'Nível', with: 'Júnior'
        fill_in 'Requisitos Obrigatórios', with: 'Nível superior'
        fill_in 'Data Limite', with: '20/06/2021'
        fill_in 'Total de Vagas', with: '10'         
        click_on 'Cadastrar Vaga'

        expect(current_path).to eq(job_path(Job.last))
        expect(page).to have_content('FullStack Remoto')
        expect(page).to have_content('Conhecimento em Ruby on Rails e desejável em React')        
        expect(page).to have_content('Cadastrada por: mauro@xyz.com.br')
    end

    scenario 'admin jobs' do        
        company = Company.create!(domain: 'xyz.com.br')
        account = Employee.create!(email: 'mauro@xyz.com.br', password: '123456', company: company, admin: false)   
        login_as account, :scope => :employee
        job = Job.create!(title: 'FullStack Remoto', description: 'Conhecimento em Ruby on Rails e desejável em React', 
                          salary: 'Entre R$ 2.500 e R$ 5.000', stage: 'Júnior', need: 'Nível superior', valid: '20/06/2021',
                          quantity: 10, company: company, status: true)
   
        visit root_path
        click_on 'Vagas'

        expect(page).to have_content('Editar Vaga')
        expect(page).to have_content('Desabilitar Vaga')
    end

    scenario 'not admin jobs in other company' do        
        company = Company.create!(domain: 'xyz.com.br')
        account = Emplyoee.create!(email: 'mauro@xyz.com.br', password: '123456', company: company, admin: false)           
        job = Job.create!(title: 'FullStack Remoto', description: 'Conhecimento em Ruby on Rails e desejável em React', 
                          salary: 'Entre R$ 2.500 e R$ 5.000', stage: 'Júnior', need: 'Nível superior', valid: '20/06/2021',
                          quantity: 10, company: company, status: true)
        another_company = Company.create!(domain: 'abc.com.br')
        another_account = Emplyoee.create!(email: 'teobaldo@abc.com.br', password: '123456', company: another_company, admin: false)           
        login_as another_account, :scope => :employee
   
        visit root_path
        click_on 'Vagas'

        expect(page).not_to have_content('Editar Vaga') 
        expect(page).not_to have_content('Desabilitar Vaga')       
    end

    scenario 'update jobs' do        
        company = Company.create!(domain: 'xyz.com.br')
        account = Emplyoee.create!(email: 'mauro@xyz.com.br', password: '123456', company: company, admin: false)
        job = Job.create!(title: 'FullStack Remoto', description: 'Conhecimento em Ruby on Rails e desejável em React', 
                          salary: 'Entre R$ 2.500 e R$ 5.000', stage: 'Júnior', need: 'Nível superior', valid: '20/06/2021',
                          quantity: 10, company: company, status: true)
        login_as account, :scope => :employee

        visit root_path
        click_on 'Vagas'
        click_on 'Editar Vaga'

        fill_in 'Titulo', with: 'FullStack Remoto Presencial'
        fill_in 'Descrição', with: 'Conhecimento em Ruby on Rails e desejável em React ou Angular'  
        click_on 'Atualizar Vaga'

        expect(current_path).to eq(job_path(Job.last))
        expect(page).to have_content('FullStack Remoto Presencial')
        expect(page).to have_content('Conhecimento em Ruby on Rails e desejável em React ou Angular')                
    end
    
    scenario 'disable jobs' do        
        company = Company.create!(domain: 'xyz.com.br')
        account = Emplyoee.create!(email: 'mauro@xyz.com.br', password: '123456', company: company, admin: false)
        job = Job.create!(title: 'FullStack Remoto', description: 'Conhecimento em Ruby on Rails e desejável em React', 
                          salary: 'Entre R$ 2.500 e R$ 5.000', stage: 'Júnior', need: 'Nível superior', valid: '20/06/2021',
                          quantity: 10, company: company, status: true)
        login_as account, :scope => :employee

        visit root_path
        click_on 'Vagas'
        click_on 'Desabilitar Vaga'

        expect(current_path).to eq(job_path)
        expect(page).not_to have_content('FullStack Remoto Presencial')        
    end    
end