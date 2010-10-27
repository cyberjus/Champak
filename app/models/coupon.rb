class Coupon < ActiveRecord::Base
  attr_accessible :business_id, :category_id, :short_description, :long_description, :valid_from, :valid_until, :image, :categories_attributes, :value, :featured, :online_only
  has_attached_file :image, :storage => :s3, :s3_credentials => "#{RAILS_ROOT}/config/s3.yml", :path => "coupon/:id/:attachment/:style.:extension", :styles => { :page => '640x', :print => '1200x' }
  
  belongs_to :business
  belongs_to :category
  
  acts_as_mappable :through => :business
  
  validates :business_id, :presence => true
  validates :short_description, :presence => true, :length => { :maximum => 250 } 
  validates :valid_from, :presence => true
  validates :valid_until, :presence => true
  validates :value, :numericality => true
  
  scope :active, where('valid_until >= ? AND valid_from <= ?', Date.today, Date.today)
  scope :expired, where('valid_until < ?', Date.today)
  
  def print 
    self.prints.nil? ? self.prints = 1 : self.prints += 1 
    self.save
    Savings.first().add_to(value)        
  end  
  
  def rate(val)
    self.rating.nil? ? self.rating = val : self.rating = ((self.total_ratings*self.rating)+val)/(self.total_ratings+1)
    self.total_ratings.nil? ? self.total_ratings = 1 : self.total_ratings += 1
    self.save
  end
  
end
