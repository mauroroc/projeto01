class AddColumnsToJobcandidate < ActiveRecord::Migration[6.1]
  def change
    add_column :job_candidates, :motive, :string
    add_column :job_candidates, :salary_proposal, :string
    add_column :job_candidates, :start_date, :date
    add_column :job_candidates, :message, :text
  end
end
