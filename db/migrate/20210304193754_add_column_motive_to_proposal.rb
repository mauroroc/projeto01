class AddColumnMotiveToProposal < ActiveRecord::Migration[6.1]
  def change
    add_column :proposals, :motive, :string
  end
end
