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
        click_on "Ver Vagas"
        click_on "FullStack Remoto"

        expect(page).to have_content('Quero me cadastrar para essa vaga')           
    end


    scenario 'visitor create account' do        
        company = Company.create!(domain: 'xyz.com.br', name:'XYZ Empreendimentos', logo: 'logo.png', cep: '40.000-000',
                                address: 'Av. Teste', address_number: '90', address_door: 'casa 27', district: 'Centro',
                                cnpj: '01.234.567/0001-89', url: 'www.xyz.com.br', linkedin: 'www.linkedin.com/xyz')
        account = Account.create!(email: 'mauro@xyz.com.br', password: '123456', company: company, admin: false)
        job = Job.create!(title: 'FullStack Remoto', description: 'Conhecimento em Ruby on Rails e desejável em React', 
                          salary: 'Entre R$ 2.500 e R$ 5.000', stage: 'Júnior', need: 'Nível superior', valid: '20/06/2021',
                          quantity: 10, company: company, account: account, status: false)
        
        visit root_path
        click_on "Ver Vagas"
        click_on "FullStack Remoto"
        click_on "Quero me cadastrar para essa vaga"
        fill_in 'Nome Completo/Nome Social', with: 'Fulano de Tal'
        fill_in 'E-mail', with: 'teste@teste.com.br'
        fill_in 'Senha', with: 'abcdef'
        fill_in 'CPF', with: '123.456.789-00'
        fill_in 'Telefone', with: '(71) 99999-1234'
        fill_in 'Biografia Resumida', with: 'Jovem, inteligente, procurando emprego'                 
        click_on 'Desejo me candidatar'

        expect(JobCandidate.count).eq (1)
    end

    scenario 'update candidate' do  
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
        
        login_as candidate

        visit root_path
        click_on 'Editar Perfil'
                        
        expect(page).to have_content('Salvar Perfil')                      
    end

end