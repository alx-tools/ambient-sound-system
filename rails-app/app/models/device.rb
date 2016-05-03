class Device < ActiveRecord::Base
  @chromecasts = Device.where("device_type = ?", "Chromecast")
end
