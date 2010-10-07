class AddOptionsToCouponTable < ActiveRecord::Migration
  def self.up
    add_column :coupons, :featured, :boolean, :default => false
    add_column :coupons, :online_only, :boolean, :default => false
  end

  def self.down
    remove_column :coupons, :featured
    remove_column :coupons, :online_only
  end
end
