class AddUserPrintsToCoupon < ActiveRecord::Migration
  def self.up
    add_column :coupons, :prints, :integer, :default => 0
    add_column :coupons, :value, :float, :default => 0
  end

  def self.down
    remove_column :coupons, :prints
    remove_column :coupons, :value
  end
end
