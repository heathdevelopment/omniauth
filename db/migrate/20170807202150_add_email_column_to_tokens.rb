class AddEmailColumnToTokens < ActiveRecord::Migration[5.1]
  def change
    add_column :tokens, :email, :string
  end
end
