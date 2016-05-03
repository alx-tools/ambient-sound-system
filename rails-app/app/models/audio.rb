# The model's class name is Audio.
class Audio < ActiveRecord::Base
  # Allows for store variable
  attr_accessor :store
  # Display error if the user has not entered in a string.
  validates_presence_of :text, :message => "You can't say nothing."
end
