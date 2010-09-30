class AdminUser < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :login, :password, :password_confirmation
  
  validates :login, :presence => true, :length => { :minimum => 5 }, :uniqueness => true
  validates :password, :presence => true, :confirmation => true, :length => { :within => 6..40 }
  
  before_save :encrypt_password
  
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(login, submitted_password)
    admin_user = find_by_login(login)
    return nil if admin_user.nil?
    return admin_user if admin_user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    admin_user = find_by_id(id)
    (admin_user && admin_user.salt == cookie_salt) ? admin_user : nil
  end
    
  private
  
    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end
    
    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")  
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
 
end
