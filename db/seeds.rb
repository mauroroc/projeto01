# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#Criando empresas
company1 = Company.create!(domain: 'xyz', name:'XYZ Empreendimentos', cep: '40.000-000',
    address: 'Av. Teste', address_number: '90', address_door: 'casa 27', district: 'Centro',
    cnpj: '01.234.567/0001-89', url: 'www.xyz.com.br', linkedin: 'www.linkedin.com/xyz')        
company2 = Company.create!(domain: 'abc', name:'ABC Holding', cep: '40.000-000',
    address: 'Av. Teste', address_number: '90', address_door: 'casa 27', district: 'Centro',
    cnpj: '01.234.567/0001-89', url: 'www.abc.com.br', linkedin: 'www.linkedin.com/abc')            

#Criando colaboradores
employee1 = Employee.create!(email: 'mauro@xyz.com.br', password: '123456', company: company1, admin: true)
employee2 = Employee.create!(email: 'mauro@abc.com.br', password: '123456', company: company2, admin: true)

#Criando vagas
job1 = Job.create!(title: 'FullStack Remoto', description: 'Conhecimento em Ruby on Rails e desejável em React', 
    salary: 1, stage: 1, need: 'Nível superior', expiration: '20/06/2021',
    quantity: 1, company: company1, status: true) 
job2 = Job.create!(title: 'FullStack Presencial', description: 'Conhecimento em Ruby on Rails e desejável em React', 
    salary: 2, stage: 2, need: 'Nível superior', expiration: '20/06/2021',
    quantity: 2, company: company1, status: true) 
job3 = Job.create!(title: 'FullStack Hibrido', description: 'Conhecimento em Ruby on Rails e desejável em React', 
    salary: 3, stage: 0, need: 'Nível superior', expiration: '20/06/2019',
    quantity: 1, company: company1, status: true) 
job4 = Job.create!(title: 'FrontEnd Remoto', description: 'Conhecimento em Ruby on Rails e desejável em React', 
    salary: 3, stage: 0, need: 'Nível superior', expiration: '20/06/2021',
    quantity: 1, company: company2, status: true) 
job5 = Job.create!(title: 'FrontEnd Presencial', description: 'Conhecimento em Ruby on Rails e desejável em React', 
    salary: 2, stage: 2, need: 'Nível superior', expiration: '20/06/2021',
    quantity: 2, company: company2, status: true) 
job6 = Job.create!(title: 'FrontEnd Hibrido', description: 'Conhecimento em Ruby on Rails e desejável em React', 
    salary: 1, stage: 1, need: 'Nível superior', expiration: '20/06/2021',
    quantity: 1, company: company2, status: false) 

#Criando Candidatos
candidate1 = Candidate.create!(name: 'Fulano de Tal', email: 'me@fulano.com.br', password: '123456', 
    cpf: '123.456.789-00', phone: '(71) 99999-1234', bio: 'Jovem, inteligente, procurando emprego')  
candidate2 = Candidate.create!(name: 'Beltrano de Tal', email: 'me@beltrano.com.br', password: '123456', 
    cpf: '456.789.123-00', phone: '(71) 99999-1234', bio: 'Jovem, inteligente, procurando emprego')
candidate3 = Candidate.create!(name: 'Ciclano de Tal', email: 'me@ciclano.com.br', password: '123456', 
    cpf: '789.123.456-00', phone: '(71) 99999-1234', bio: 'Jovem, inteligente, procurando emprego')

#Candidatos aplicam as vagas
job_candidate1 = JobCandidate.create!(job: job1, candidate: candidate1, status: 0)
job_candidate2 = JobCandidate.create!(job: job1, candidate: candidate2, status: 0)
job_candidate3 = JobCandidate.create!(job: job2, candidate: candidate2, status: 0)
job_candidate4 = JobCandidate.create!(job: job2, candidate: candidate3, status: 0)
job_candidate5 = JobCandidate.create!(job: job4, candidate: candidate3, status: 0)
job_candidate6 = JobCandidate.create!(job: job4, candidate: candidate1, status: 0)