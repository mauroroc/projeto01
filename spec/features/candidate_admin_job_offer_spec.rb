require 'rails_helper'

feature 'Candidate admin job offers' do
    scenario 'page is correct' do  
        candidate = Candidate.create!(name: 'Fulano de Tal', email: 'teste@teste.com.br', password: 'abcdef', 
                                    cpf: '123.456.789-00', phone: '(71) 99999-1234', bio: 'Jovem, inteligente, procurando emprego')                  
        company = Company.create!(domain: 'xyz', name:'XYZ Empreendimentos', cep: '40.000-000',
                                address: 'Av. Teste', address_number: '90', address_door: 'casa 27', district: 'Centro',
                                cnpj: '01.234.567/0001-89', url: 'www.xyz.com.br', linkedin: 'www.linkedin.com/xyz')        
        job1 = Job.create!(title: 'FullStack Remoto', description: 'Conhecimento em Ruby on Rails e desejável em React', 
            salary: 1, stage: 1, need: 'Nível superior', expiration: '20/06/2021',
            quantity: 10, company: company, status: true)   
        job2 = Job.create!(title: 'FullStack Presencial', description: 'Conhecimento em Ruby on Rails e desejável em React', 
            salary: 1, stage: 1, need: 'Nível superior', expiration: '20/06/2021',
            quantity: 10, company: company, status: true)                          
        job_candidate_decline = JobCandidate.create!(job: job1, candidate: candidate, status: 1, motive: 'Pouca experiência no momento', message: 'Continue tentando') 
        job_candidate_proposal = JobCandidate.create!(job: job2, candidate: candidate, status: 2, message: 'Gostamos muito do seu perfil, queremos contratá-lo', 
                                        salary_proposal: 'R$ 3.500 com beneficios', start_date: '20/03/2021') 
        
        login_as candidate, :scope => :candidate
        visit root_path
        click_on "Minhas Ofertas"

        expect(page).to have_content('Candidato Declinado')  
        expect(page).to have_content('Proposta Feita')                   
    end

    scenario 'Candidate refuse offer' do
        candidate = Candidate.create!(name: 'Fulano de Tal', email: 'teste@teste.com.br', password: 'abcdef', 
            cpf: '123.456.789-00', phone: '(71) 99999-1234', bio: 'Jovem, inteligente, procurando emprego')                  
        company = Company.create!(domain: 'xyz', name:'XYZ Empreendimentos', cep: '40.000-000',
            address: 'Av. Teste', address_number: '90', address_door: 'casa 27', district: 'Centro',
            cnpj: '01.234.567/0001-89', url: 'www.xyz.com.br', linkedin: 'www.linkedin.com/xyz')        
        job = Job.create!(title: 'FullStack Remoto', description: 'Conhecimento em Ruby on Rails e desejável em React', 
            salary: 1, stage: 1, need: 'Nível superior', expiration: '20/06/2021',
            quantity: 10, company: company, status: true)   
        job_candidate = JobCandidate.create!(job: job, candidate: candidate, status: 2, message: 'Gostamos muito do seu perfil, queremos contratá-lo', 
                        salary_proposal: 'R$ 3.500 com beneficios', start_date: '20/03/2021') 

        login_as candidate, :scope => :candidate
        visit root_path
        click_on "Minhas Ofertas"           
        click_on "Ver essa candidatura"
        click_on "Recusar Oferta"
        fill_in 'Motivo', with: 'Não tenho interesse no valor oferecido'
        click_on "Confirmar Recusa"
                
        expect(page).to have_content('Proposta Recusada') 

    end

    scenario 'Candidate accept offer' do
        candidate = Candidate.create!(name: 'Fulano de Tal', email: 'teste@teste.com.br', password: 'abcdef', 
            cpf: '123.456.789-00', phone: '(71) 99999-1234', bio: 'Jovem, inteligente, procurando emprego')                  
        company = Company.create!(domain: 'xyz', name:'XYZ Empreendimentos', cep: '40.000-000',
            address: 'Av. Teste', address_number: '90', address_door: 'casa 27', district: 'Centro',
            cnpj: '01.234.567/0001-89', url: 'www.xyz.com.br', linkedin: 'www.linkedin.com/xyz')        
        job = Job.create!(title: 'FullStack Remoto', description: 'Conhecimento em Ruby on Rails e desejável em React', 
            salary: 1, stage: 1, need: 'Nível superior', expiration: '20/06/2021',
            quantity: 10, company: company, status: true)   
        job_candidate = JobCandidate.create!(job: job, candidate: candidate, status: 2, message: 'Gostamos muito do seu perfil, queremos contratá-lo', 
                        salary_proposal: 'R$ 3.500 com beneficios', start_date: '20/03/2021') 

        login_as candidate, :scope => :candidate
        visit root_path
        click_on "Minhas Ofertas"
        click_on "Ver essa candidatura"
        click_on "Aceitar Oferta"  
        check "Confirmo a data de inicio"
        click_on "Aceitar Proposta"
       
        expect(page).to have_content('Proposta Aceita') 
    end
end