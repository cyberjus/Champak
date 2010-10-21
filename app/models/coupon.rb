class Coupon < ActiveRecord::Base
  attr_accessible :business_id, :category_id, :short_description, :long_description, :valid_from, :valid_until, :image, :categories_attributes, :value, :featured, :online_only
  has_attached_file :image, :storage => :s3, :s3_credentials => "#{RAILS_ROOT}/config/s3.yml", :path => "coupon/:id/:attachment/:style.:extension"
  
  belongs_to :business
  belongs_to :category
  
  validates :business_id, :presence => true
  validates :short_description, :presence => true, :length => { :maximum => 250 } 
  validates :valid_from, :presence => true
  validates :valid_until, :presence => true
  validates :value, :numericality => true
  
  scope :active, where('valid_until >= ? ', Date.today)
  
  def print 
    self.prints.nil? ? self.prints = 1 : self.prints += 1 
    self.save
    Savings.first().add_to(self.value)        
  end  
  
end
