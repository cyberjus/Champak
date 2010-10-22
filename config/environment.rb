# Load the rails application
require File.expand_path('../application', __FILE__)

CONFIG = APP_CONFIG[Rails.env]

# Initialize the rails application
Champax::Application.initialize!
