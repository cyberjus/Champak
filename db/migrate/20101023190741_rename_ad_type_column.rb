class RenameAdTypeColumn < ActiveRecord::Migration
  def self.up
    rename_column :ads, :type, :banner_type
  end

  def self.down
    rename_column :ads, :banner_type, :type
  end
end
