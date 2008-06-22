require 'net/http'
require 'xmlsimple'
require 'r_weather_current_condition'

RWeatherLocation = Struct.new(:type, :id, :name)

class RWeather
  
  NOT_AUTHENTICATED = 'You should set partner_id and key values on RWeather before calling data request actions.'
  SEARCH_URL = 'http://xoap.weather.com/search/search?where=%s'
  LOCAL_URL = 'http://xoap.weather.com/weather/local/%s?par=%s&key=%s&link=xoap&prod=xoap'

  VALID_UNITS = ['s', 'm']
  DEFAULT_UNIT = 's' #standard

  def self.partner_id; @@partner_id; end
  def self.partner_id=(value); @@partner_id = value; end

  def self.key; @@key; end
  def self.key=(value); @@key = value; end

  def self.search(where)
    if data = get_and_parse(sprintf(SEARCH_URL, where))
      data['loc'].map{|loc| RWeatherLocation.new(loc['type'], loc['id'], loc['content'])}
    end
  end
  
  def self.current_conditions(location_id, unit = DEFAULT_UNIT)
    check_authentication
    url = sprintf(LOCAL_URL, location_id, partner_id, key)
    url << "&cc=true"
    url << "&unit=#{unit}" if VALID_UNITS.include?(unit)
    if data = get_and_parse(url)
      RWeatherCurrentCondition.parse(data)
    end
  end
  
  def self.local(partner_id, key)
    check_authentication
  end
  
  
  class << self
    def check_authentication
      raise Exception.new(NOT_AUTHENTICATED) if @@partner_id.nil? || @@partner_id.empty? || @@key.nil? || @@key.empty?
    end

    def get_and_parse(url)
      xml_data = Net::HTTP.get_response(URI.parse(url)).body
      XmlSimple.xml_in(xml_data)
    end
  end
end
