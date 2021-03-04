class CreateProposals < ActiveRecord::Migration[6.1]
  def change
    create_table :proposals do |t|
      t.string :salary_proposal
      t.date :start_date
      t.text :message
      t.integer :status
      t.references :job_candidate, null: false, foreign_key: true

      t.timestamps
    end
  end
end
