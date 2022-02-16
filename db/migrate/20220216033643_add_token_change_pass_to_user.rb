class AddTokenChangePassToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :token_change_pass, :string
  end
end
