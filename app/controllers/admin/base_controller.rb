class Admin::BaseController < ApplicationController
  include Admin::SessionsHelper
  
  layout 'admin'
  
  private 
    
    def authenticate
      deny_access unless signed_in?
    end
  
end
