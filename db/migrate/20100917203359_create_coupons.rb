class CreateCoupons < ActiveRecord::Migration
  def self.up
    create_table :coupons do |t|
      t.integer :business_id
      t.integer :category_id
      t.string :short_description
      t.text :long_description
      t.date :valid_from
      t.date :valid_until
      t.string :image

      t.timestamps
    end
    add_index :coupons, :business_id
    add_index :coupons, :category_id
  end

  def self.down
    drop_table :coupons
  end
end
