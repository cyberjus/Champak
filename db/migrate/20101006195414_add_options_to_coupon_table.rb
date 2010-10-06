class AddOptionsToCouponTable < ActiveRecord::Migration
  def self.up
    add_column :coupons, :featured, :boolean
    add_column :coupons, :online_only, :boolean
  end

  def self.down
    remove_column :coupons, :featured
    remove_column :coupons, :online_only
  end
end
