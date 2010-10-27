class AddRatingsToCoupons < ActiveRecord::Migration
  def self.up
    add_column :coupons, :rating, :float, :default => 0
    add_column :coupons, :total_ratings, :integer, :default => 0
  end

  def self.down
    remove_column :coupons, :rating
    remove_column :coupons, :total_ratings
  end
end
