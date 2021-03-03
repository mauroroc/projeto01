require 'rails_helper'

feature 'Job disable automatic' do
    scenario 'job offer decrease and disabled' do
        candidate = Candidate.create!(name: 'Fulano de Tal', email: 'teste@teste.com.br', password: 'abcdef', 
            cpf: '123.456.789-00', phone: '(71) 99999-1234', bio: 'Jovem, inteligente, procurando emprego')                  
        company = Company.create!(domain: 'xyz', name:'XYZ Empreendimentos', cep: '40.000-000',
            address: 'Av. Teste', address_number: '90', address_door: 'casa 27', district: 'Centro',
            cnpj: '01.234.567/0001-89', url: 'www.xyz.com.br', linkedin: 'www.linkedin.com/xyz')        
        job = Job.create!(title: 'FullStack Remoto', description: 'Conhecimento em Ruby on Rails e desejável em React', 
            salary: 1, stage: 1, need: 'Nível superior', expiration: '20/06/2021',
            quantity: 1, company: company, status: true)   
        job_candidate = JobCandidate.create!(job: job, candidate: candidate, status: 2, message: 'Gostamos muito do seu perfil, queremos contratá-lo', 
                        salary_proposal: 'R$ 3.500 com beneficios', start_date: '20/03/2021') 

        login_as candidate, :scope => :candidate
        visit root_path
        click_on "Minhas Ofertas"
        click_on "Ver essa candidatura"
        click_on "Aceitar Oferta"  
        check "Confirmo a data de inicio"
        click_on "Aceitar Proposta"

        job.reload
        expect(job.quantity).to eq(0) 
        expect(job.status).to eq('inactive') 
    end  
end