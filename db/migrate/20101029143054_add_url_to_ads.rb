class AddUrlToAds < ActiveRecord::Migration
  def self.up
    add_column :ads, :url, :string
  end

  def self.down
    remove_colum :ads, :url
  end
end
