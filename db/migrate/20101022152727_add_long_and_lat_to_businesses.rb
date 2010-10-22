class AddLongAndLatToBusinesses < ActiveRecord::Migration
  def self.up
    add_column :businesses, :lat, :decimal
    add_column :businesses, :lng, :decimal
    add_index :businesses, :lat
    add_index :businesses, :lng  
  end

  def self.down
    remove_column :businesses, :lat
    remove_column :businesses, :lng
    remove_index :businesses, :lat
    remove_index :businesses, :lng  
  end
end
