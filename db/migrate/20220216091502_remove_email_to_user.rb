class RemoveEmailToUser < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :email, :index_users_on_email
  end
end
