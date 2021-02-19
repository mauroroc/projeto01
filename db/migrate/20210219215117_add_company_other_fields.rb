class AddCompanyOtherFields < ActiveRecord::Migration[6.1]
  def change
    add_column :companies, :name, :string
    add_column :companies, :logo, :string
    add_column :companies, :cep, :string
    add_column :companies, :address, :string
    add_column :companies, :address_number, :string
    add_column :companies, :address_door, :string
    add_column :companies, :district, :string
    add_column :companies, :city, :string
    add_column :companies, :state, :string
    add_column :companies, :cnpj, :string
    add_column :companies, :url, :string
    add_column :companies, :linkedin, :string
  end
end
