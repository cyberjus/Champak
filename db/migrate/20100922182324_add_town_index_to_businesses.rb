class AddTownIndexToBusinesses < ActiveRecord::Migration
  def self.up
    add_index :businesses, :town
  end

  def self.down
    remove_index :businesses, :town
  end
end
