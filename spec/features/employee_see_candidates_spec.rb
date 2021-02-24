require 'rails_helper'

feature 'Employee see candidates' do
    scenario 'page is correct' do  
        candidate = Candidate.create!(name: 'Fulano de Tal', email: 'teste@teste.com.br', password: 'abcdef', 
            cpf: '123.456.789-00', phone: '(71) 99999-1234', bio: 'Jovem, inteligente, procurando emprego')                  
        company = Company.create!(domain: 'xyz.com.br', name:'XYZ Empreendimentos', logo: 'logo.png', cep: '40.000-000',
            address: 'Av. Teste', address_number: '90', address_door: 'casa 27', district: 'Centro',
            cnpj: '01.234.567/0001-89', url: 'www.xyz.com.br', linkedin: 'www.linkedin.com/xyz')
        account = Employee.create!(email: 'mauro@xyz.com.br', password: '123456', company: company, admin: false)
        job = Job.create!(title: 'FullStack Remoto', description: 'Conhecimento em Ruby on Rails e desejável em React', 
            salary: 1, stage: 1, need: 'Nível superior', expiration: '20/06/2021',
            quantity: 10, company: company, status: true)
        job_candidate = JobCandidate.create!(job: job, candidate: candidate, status: 0) # 0 é pendente
        
        login_as account, :scope => :employee
        visit root_path
        click_on "Ver Candidaturas"                

        expect(page).to have_content('Ver essa candidatura')           
    end

    scenario 'admin candidate' do  
        candidate = Candidate.create!(name: 'Fulano de Tal', email: 'teste@teste.com.br', password: 'abcdef', 
            cpf: '123.456.789-00', phone: '(71) 99999-1234', bio: 'Jovem, inteligente, procurando emprego')                  
        company = Company.create!(domain: 'xyz.com.br', name:'XYZ Empreendimentos', logo: 'logo.png', cep: '40.000-000',
            address: 'Av. Teste', address_number: '90', address_door: 'casa 27', district: 'Centro',
            cnpj: '01.234.567/0001-89', url: 'www.xyz.com.br', linkedin: 'www.linkedin.com/xyz')
        account = Employee.create!(email: 'mauro@xyz.com.br', password: '123456', company: company, admin: false)
        job = Job.create!(title: 'FullStack Remoto', description: 'Conhecimento em Ruby on Rails e desejável em React', 
            salary: 1, stage: 1, need: 'Nível superior', expiration: '20/06/2021',
            quantity: 10, company: company, status: true)
        job_candidate = JobCandidate.create!(job: job, candidate: candidate, status: 0) # 0 é pendente
        
        login_as account, :scope => :employee
        visit root_path
        click_on "Ver Candidaturas"
        click_on "Ver essa candidatura"        

        expect(page).to have_content('Pendente de Avaliação')
        expect(page).to have_content('Declinar Candidatura')
        expect(page).to have_content('Enviar Proposta')
    end

    scenario 'decline candidate' do  
        candidate = Candidate.create!(name: 'Fulano de Tal', email: 'teste@teste.com.br', password: 'abcdef', 
            cpf: '123.456.789-00', phone: '(71) 99999-1234', bio: 'Jovem, inteligente, procurando emprego')                  
        company = Company.create!(domain: 'xyz.com.br', name:'XYZ Empreendimentos', logo: 'logo.png', cep: '40.000-000',
            address: 'Av. Teste', address_number: '90', address_door: 'casa 27', district: 'Centro',
            cnpj: '01.234.567/0001-89', url: 'www.xyz.com.br', linkedin: 'www.linkedin.com/xyz')
        account = Employee.create!(email: 'mauro@xyz.com.br', password: '123456', company: company, admin: false)
        job = Job.create!(title: 'FullStack Remoto', description: 'Conhecimento em Ruby on Rails e desejável em React', 
            salary: 1, stage: 1, need: 'Nível superior', expiration: '20/06/2021',
            quantity: 10, company: company, status: true)
        job_candidate = JobCandidate.create!(job: job, candidate: candidate, status: 0) # 0 é pendente
        
        login_as account, :scope => :employee
        visit root_path
        click_on "Ver Candidaturas"
        click_on "Ver essa candidatura"   
        click_on "Declinar Candidatura"

        fill_in 'Motivo', with: 'Pouca experiência no momento'  
        fill_in 'Mensagem', with: 'Gostamos muito do seu perfil, mas acho que precisa de mais experiência'  
        click_on 'Declinar Candidato'     
        
        job_candidate.reload
        expect(job_candidate.status).to eq('Candidato Declinado')
        expect(job_candidate.motive).to eq('Pouca experiência no momento')
    end

    scenario 'send proposal' do  
        candidate = Candidate.create!(name: 'Fulano de Tal', email: 'teste@teste.com.br', password: 'abcdef', 
            cpf: '123.456.789-00', phone: '(71) 99999-1234', bio: 'Jovem, inteligente, procurando emprego')                  
        company = Company.create!(domain: 'xyz.com.br', name:'XYZ Empreendimentos', logo: 'logo.png', cep: '40.000-000',
            address: 'Av. Teste', address_number: '90', address_door: 'casa 27', district: 'Centro',
            cnpj: '01.234.567/0001-89', url: 'www.xyz.com.br', linkedin: 'www.linkedin.com/xyz')
        account = Employee.create!(email: 'mauro@xyz.com.br', password: '123456', company: company, admin: false)
        job = Job.create!(title: 'FullStack Remoto', description: 'Conhecimento em Ruby on Rails e desejável em React', 
            salary: 1, stage: 1, need: 'Nível superior', expiration: '20/06/2021',
            quantity: 10, company: company, status: true)
        job_candidate = JobCandidate.create!(job: job, candidate: candidate, status: 0) # 0 é pendente
        
        login_as account, :scope => :employee
        visit root_path
        click_on "Ver Candidaturas"
        click_on "Ver essa candidatura"   
        click_on "Enviar Proposta"

        fill_in 'Mensagem', with: 'Gostamos muito do seu perfil, queremos contratá-lo'
        fill_in 'Proposta Salarial', with: 'R$ 3.500 com beneficios'  
        fill_in 'Data de Inicio', with: '20/03/2021'  
        click_on 'Enviar Proposta'     

        job_candidate.reload
        expect(job_candidate.status).to eq("Proposta Feita") 
        expect(job_candidate.message).to eq('Gostamos muito do seu perfil, queremos contratá-lo')
        expect(job_candidate.salary_proposal).to eq('R$ 3.500 com beneficios')          
    end
end