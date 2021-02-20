class RemoveEmployeeToJobs < ActiveRecord::Migration[6.1]
  def change
    remove_reference :jobs, :employee, null: false, foreign_key: true    
  end
end
