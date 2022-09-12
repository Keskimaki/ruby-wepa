class Weather < OpenStruct
  def self.rendered_fields
    [:temperature, :name, :weather_icons, :wind_speed, :wind_dir]
  end
end
