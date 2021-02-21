class JobChangeColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :jobs, :valid, :expiration
  end
end
