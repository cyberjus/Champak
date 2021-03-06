class AdjustImageInCoupon < ActiveRecord::Migration
  def self.up
    remove_column :coupons, :image
    add_column :coupons, :image_file_name, :string
    add_column :coupons, :image_content_type, :string
    add_column :coupons, :image_file_size, :integer
    add_column :coupons, :image_updated_at, :datetime
  end

  def self.down
    add_column :coupons, :image, :string
    remove_column :coupons, :image_file_name
    remove_column :coupons, :image_content_type
    remove_column :coupons, :image_file_size
    remove_column :coupons, :image_updated_at
  end
end
