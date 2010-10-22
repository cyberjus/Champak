class Business < ActiveRecord::Base
  attr_accessible :name, :address, :town, :state, :zipcode, :website_url
  
  has_many :coupons, :dependent => :destroy
  
  acts_as_mappable
  
  before_save :geocode_address
  
  validates :name, :presence => true
  validates :town, :presence => true
  validates :state, :presence => true, :length => { :maximum => 2 }
  validates :zipcode, :presence => true, :length => { :maximum => 5 }
  
  def self.update_states_and_geocode
    Business.all.each do |b|
      b.state = 'VT'
      b.save
    end
  end
  
  private
  
  def geocode_address
    self.lat, self.lng = ''
    geo=Geokit::Geocoders::MultiGeocoder.geocode("#{address}, #{town}, #{state} #{zipcode}")
    self.lat, self.lng = geo.lat,geo.lng if geo.success && geo.zip == self.zipcode
  end 
    
end
