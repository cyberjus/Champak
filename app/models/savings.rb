class Savings < ActiveRecord::Base
  
  def add_to(val)
    self.value += val
    self.save
  end
  
  
end
