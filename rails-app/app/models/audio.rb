# The model's class name is Audio.
class Audio < ActiveRecord::Base
  # Allows for store variable
  attr_accessor :store
  attr_writer :file_path, :url

  def path
    "public/audio/"
  end

  def url_path
    "http://192.168.1.121:3000/audio/"
  end

  def file_path
    if file
      return path + file
    else
      false
    end
  end

  def url
    if file
      return url_path + file
    else
      false
    end
  end

  # Display error if the user has not entered in a string.
  validates_presence_of :text, :message => "You can't say nothing."
end
