class Ad < ActiveRecord::Base
  attr_accessible :name, :banner_type, :image
  has_attached_file :image, :storage => :s3, :s3_credentials => "#{RAILS_ROOT}/config/s3.yml", :path => "ad/:id/:style.:extension"
  
  validates :name, :presence => true
  validates :banner_type, :presence => true
  
  TYPES = { 'Wide Skyscraper (160x600)' => 'wide_skyscraper' }
  
end
