class Employee < ApplicationRecord
  belongs_to :company
  before_validation :ensure_create_company

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  private
    def ensure_create_company
      domain = self.email.gsub(/.+@([^.]+).+/, '\1') #obtem o dominio do e-mail
      companyExist = Company.find_by(domain: domain)
      if companyExist
        self.company = companyExist        
      else
        company = Company.create!(domain: domain) 
        self.company = company
        self.admin = true
      end      
    end

end
