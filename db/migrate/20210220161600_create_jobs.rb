class CreateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.integer :salary
      t.integer :stage
      t.text :need
      t.date :valid
      t.integer :quantity
      t.references :company, null: false, foreign_key: true
      t.references :employee, null: false, foreign_key: true      
      t.boolean :status

      t.timestamps
    end
  end
end
