require 'rails_helper'

feature 'Job disable automatic' do
    scenario 'job offer decrease' do
        candidate = Candidate.create!(name: 'Fulano de Tal', email: 'teste@teste.com.br', password: 'abcdef', 
                        cpf: '123.456.789-00', phone: '(71) 99999-1234', bio: 'Jovem, inteligente, procurando emprego')                  
        company = Company.create!(domain: 'xyz.com.br', name:'XYZ Empreendimentos', logo: 'logo.png', cep: '40.000-000',
                        address: 'Av. Teste', address_number: '90', address_door: 'casa 27', district: 'Centro',
                        cnpj: '01.234.567/0001-89', url: 'www.xyz.com.br', linkedin: 'www.linkedin.com/xyz')
        account = Account.create!(email: 'mauro@xyz.com.br', password: '123456', company: company, admin: false)
        job = Job.create!(title: 'FullStack Remoto', description: 'Conhecimento em Ruby on Rails e desejável em React', 
                        salary: 'Entre R$ 2.500 e R$ 5.000', stage: 'Júnior', need: 'Nível superior', valid: '20/06/2021',
                        quantity: 10, company: company, account: account, status: true)                      
        job_candidate = JobCandidate.create!(job: job2, candidate: candidate, status: 2, message: 'Gostamos muito do seu perfil, queremos contratá-lo', 
                        salary_proposal: 'R$ 3.500 com beneficios', start_date: '20/03/2021') 

        login_as candidate
        visit root_path
        click_on "Ver Ofertas"
        click_on "Aceitar Oferta"        
        click_on "Confirmar Data de Inicio"

        expect(job.quantity).eq (9) 
    end  
    
    scenario 'job offer disable' do
        company = Company.create!(domain: 'xyz.com.br', name:'XYZ Empreendimentos', logo: 'logo.png', cep: '40.000-000',
                                address: 'Av. Teste', address_number: '90', address_door: 'casa 27', district: 'Centro',
                                cnpj: '01.234.567/0001-89', url: 'www.xyz.com.br', linkedin: 'www.linkedin.com/xyz')
        account = Account.create!(email: 'mauro@xyz.com.br', password: '123456', company: company, admin: false)
        job = Job.create!(title: 'FullStack Remoto', description: 'Conhecimento em Ruby on Rails e desejável em React', 
                          salary: 'Entre R$ 2.500 e R$ 5.000', stage: 'Júnior', need: 'Nível superior', valid: '20/06/2021',
                          quantity: 0, company: company, account: account, status: false)
        
        visit root_path
        click_on "Ver Vagas"
        click_on "FullStack Remoto"

        expect(page).not_to have_content('FullStack Remoto') 
    end  
end