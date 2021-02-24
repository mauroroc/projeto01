class CreateJobCandidates < ActiveRecord::Migration[6.1]
  def change
    create_table :job_candidates do |t|
      t.references :job, null: false, foreign_key: true
      t.references :candidate, null: false, foreign_key: true
      t.integer :status
      t.timestamps
    end
  end
end
