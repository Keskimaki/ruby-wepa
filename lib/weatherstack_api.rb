class WeatherstackApi
  def self.weather_for(city)
    city = city.downcase
    Rails.cache.fetch("#{city}_weather", expires_in: 1.hour) { get_weather_for(city) }
  end

  def self.get_weather_for(city)
    url = "http://api.weatherstack.com/current?access_key=#{key}&query=#{city}"

    response = HTTParty.get(url)
    weather = response.parsed_response["current"]

    return nil if weather.nil?
  
    Weather.new(weather)
  end
  

  def self.key
    return nil if Rails.env.test?
    raise 'WEATHERSTACK_APIKEY env variable not defined' if ENV['WEATHERSTACK_APIKEY'].nil?

    ENV.fetch('WEATHERSTACK_APIKEY')
  end
end
