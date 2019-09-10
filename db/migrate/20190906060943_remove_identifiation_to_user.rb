class RemoveIdentifiationToUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :identifiation, :string
    add_column :users, :identification, :string
  end
end
