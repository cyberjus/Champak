class AddStateToBusinessesTable < ActiveRecord::Migration
  def self.up
    add_column :businesses, :state, :string
  end

  def self.down
    remove_column :businesses, :state
  end
end
