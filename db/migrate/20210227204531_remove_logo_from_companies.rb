class RemoveLogoFromCompanies < ActiveRecord::Migration[6.1]
  def change
    remove_column :companies, :logo, :string
  end
end
