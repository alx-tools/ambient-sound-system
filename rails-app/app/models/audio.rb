# The model's class name is Audio.
class Audio < ActiveRecord::Base
  # Display error if the user has not entered in a string.
  validates_presence_of :text, :message => "You can't say nothing."
end
