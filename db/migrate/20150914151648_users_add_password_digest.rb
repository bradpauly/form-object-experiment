class UsersAddPasswordDigest < ActiveRecord::Migration
  def change
    add_column :users, :password_digest, :string, default: nil
  end
end
