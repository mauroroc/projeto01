require 'rails_helper'

feature 'Employee see candidates' do
    scenario 'page is correct' do  
        candidate = Candidate.create!(name: 'Fulano de Tal', email: 'teste@teste.com.br', password: 'abcdef', 
                                    cpf: '123.456.789-00', phone: '(71) 99999-1234', bio: 'Jovem, inteligente, procurando emprego')                  
        company = Company.create!(domain: 'xyz.com.br', name:'XYZ Empreendimentos', logo: 'logo.png', cep: '40.000-000',
                                address: 'Av. Teste', address_number: '90', address_door: 'casa 27', district: 'Centro',
                                cnpj: '01.234.567/0001-89', url: 'www.xyz.com.br', linkedin: 'www.linkedin.com/xyz')
        account = Account.create!(email: 'mauro@xyz.com.br', password: '123456', company: company, admin: false)
        job = Job.create!(title: 'FullStack Remoto', description: 'Conhecimento em Ruby on Rails e desejável em React', 
                          salary: 'Entre R$ 2.500 e R$ 5.000', stage: 'Júnior', need: 'Nível superior', valid: '20/06/2021',
                          quantity: 10, company: company, account: account, status: true)
        job_candidate = JobCandidate.create!(job: job, candidate: candidate, status: 0) # 0 é pendente
        
        login_as account
        visit root_path
        click_on "Ver Candidaturas"                

        expect(page).to have_content('Ver candidato')           
    end

    scenario 'admin candidate' do  
        candidate = Candidate.create!(name: 'Fulano de Tal', email: 'teste@teste.com.br', password: 'abcdef', 
                                    cpf: '123.456.789-00', phone: '(71) 99999-1234', bio: 'Jovem, inteligente, procurando emprego')                  
        company = Company.create!(domain: 'xyz.com.br', name:'XYZ Empreendimentos', logo: 'logo.png', cep: '40.000-000',
                                address: 'Av. Teste', address_number: '90', address_door: 'casa 27', district: 'Centro',
                                cnpj: '01.234.567/0001-89', url: 'www.xyz.com.br', linkedin: 'www.linkedin.com/xyz')
        account = Account.create!(email: 'mauro@xyz.com.br', password: '123456', company: company, admin: false)
        job = Job.create!(title: 'FullStack Remoto', description: 'Conhecimento em Ruby on Rails e desejável em React', 
                          salary: 'Entre R$ 2.500 e R$ 5.000', stage: 'Júnior', need: 'Nível superior', valid: '20/06/2021',
                          quantity: 10, company: company, account: account, status: true)
        job_candidate = JobCandidate.create!(job: job, candidate: candidate, status: 0) # 0 é pendente
        
        login_as account
        visit root_path
        click_on "Ver Candidaturas"
        click_on "Ver Candidato"        

        expect(page).to have_content('Status: Pendente de Avaliação')
        expect(page).to have_content('Declinar Candidatura')
        expect(page).to have_content('Enviar Proposta')
    end

    scenario 'decline candidate' do  
        candidate = Candidate.create!(name: 'Fulano de Tal', email: 'teste@teste.com.br', password: 'abcdef', 
                                    cpf: '123.456.789-00', phone: '(71) 99999-1234', bio: 'Jovem, inteligente, procurando emprego')                  
        company = Company.create!(domain: 'xyz.com.br', name:'XYZ Empreendimentos', logo: 'logo.png', cep: '40.000-000',
                                address: 'Av. Teste', address_number: '90', address_door: 'casa 27', district: 'Centro',
                                cnpj: '01.234.567/0001-89', url: 'www.xyz.com.br', linkedin: 'www.linkedin.com/xyz')
        account = Account.create!(email: 'mauro@xyz.com.br', password: '123456', company: company, admin: false)
        job = Job.create!(title: 'FullStack Remoto', description: 'Conhecimento em Ruby on Rails e desejável em React', 
                          salary: 'Entre R$ 2.500 e R$ 5.000', stage: 'Júnior', need: 'Nível superior', valid: '20/06/2021',
                          quantity: 10, company: company, account: account, status: true)
        job_candidate = JobCandidate.create!(job: job, candidate: candidate, status: 0) # 0 é pendente
        
        login_as account
        visit root_path
        click_on "Ver Candidaturas"
        click_on "Ver Candidato"   
        click_on "Declinar Candidatura"

        fill_in 'Motivo', with: 'Pouca experiência no momento'  
        click_on 'Confirmar'     

        expect(job_candidate.status).eq (1) # 1 é declinado
        expect(job_candidate.motive).eq ('Pouca experiência no momento')
    end

    scenario 'send proposal' do  
        candidate = Candidate.create!(name: 'Fulano de Tal', email: 'teste@teste.com.br', password: 'abcdef', 
                                    cpf: '123.456.789-00', phone: '(71) 99999-1234', bio: 'Jovem, inteligente, procurando emprego')                  
        company = Company.create!(domain: 'xyz.com.br', name:'XYZ Empreendimentos', logo: 'logo.png', cep: '40.000-000',
                                address: 'Av. Teste', address_number: '90', address_door: 'casa 27', district: 'Centro',
                                cnpj: '01.234.567/0001-89', url: 'www.xyz.com.br', linkedin: 'www.linkedin.com/xyz')
        account = Account.create!(email: 'mauro@xyz.com.br', password: '123456', company: company, admin: false)
        job = Job.create!(title: 'FullStack Remoto', description: 'Conhecimento em Ruby on Rails e desejável em React', 
                          salary: 'Entre R$ 2.500 e R$ 5.000', stage: 'Júnior', need: 'Nível superior', valid: '20/06/2021',
                          quantity: 10, company: company, account: account, status: true)
        job_candidate = JobCandidate.create!(job: job, candidate: candidate, status: 0) # 0 é pendente
        
        login_as account
        visit root_path
        click_on "Ver Candidaturas"
        click_on "Ver Candidato"   
        click_on "Enviar Proposta"

        fill_in 'Mensagem', with: 'Gostamos muito do seu perfil, queremos contratá-lo'
        fill_in 'Proposta Salarial', with: 'R$ 3.500 com beneficios'  
        fill_in 'Iniciar em', with: '20/03/2021'  
        click_on 'Confirmar'     

        expect(job_candidate.status).eq (2) # 2 é proposta feita
        expect(job_candidate.message).eq ('Gostamos muito do seu perfil, queremos contratá-lo')
        expect(job_candidate.salary_proposal).eq ('R$ 3.500 com beneficios')
        expect(job_candidate.start_date).eq ('20/03/2021')    
    end
end