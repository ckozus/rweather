RWeatherBar = Struct.new(:r, :d)
RWeatherWind = Struct.new(:s, :gust, :d, :t)
RWeatherUv = Struct.new(:i, :t)
RWeatherMoon = Struct.new(:icon, :t)

class RWeatherCurrentCondition
  attr_accessor :lsup, :obst, :tmp, :flik, :t, :icon, :bar, :wind, :hmid, :vis, :uv, :dewp, :moon
  
  def self.parse(simple_xml)
    current_condition = new
    cc = simple_xml['cc'].first
    cc.each do |key, value|
      current_condition.send(:"#{key}=", element_value(key, value))
    end
    current_condition
  end

  class << self
    def element_value(key, value)
      if value.size == 1 && !value.first.is_a?(Hash)
        value.first
      else
        data = const_get(:"RWeather#{key.capitalize}").new
        value.first.each do |key, value|
          data.send(:"#{key}=", value.first)
        end
        data
      end
    end
  end
end
