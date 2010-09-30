class CreateAdminUsers < ActiveRecord::Migration
  def self.up
    create_table :admin_users do |t|
      t.string :login
      t.string :encrypted_password
      t.string :salt

      t.timestamps
    end
    add_index :admin_users, :login, :unique => true
  end

  def self.down
    drop_table :admin_users
  end
end
