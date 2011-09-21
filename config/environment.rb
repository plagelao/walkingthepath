# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Walkingthepath::Application.initialize!
Time::DATE_FORMATS[:walking] = '%d/%m/%Y %H:%M'
