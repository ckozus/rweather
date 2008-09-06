require 'lib/r_weather_current_condition'
require 'xmlsimple'

describe RWeatherCurrentCondition, 'parse' do
  
  before :each do
    file_data = File.open('spec/current_condition.xml', 'r') {|f| f.read}
    @xml_data = XmlSimple.xml_in(file_data)
  end
  
  it "should parse simple xml data" do
    cc = RWeatherCurrentCondition.parse(@xml_data)
    cc.lsup.should == '6/22/08 11:00 AM Local Time'
    cc.obst.should == 'San Miguel de Tucuman, Argentina'
    cc.tmp.should == "7"
    cc.flik.should == "5"
    cc.t.should == 'Partly Cloudy'
    cc.icon.should == "30"
    cc.hmid.should == "87"
    cc.vis.should == "6.0"
    cc.dewp.should == "5" 
  end
  
  it "should parse bar xml data" do
    cc = RWeatherCurrentCondition.parse(@xml_data)
    cc.bar.should be_kind_of(RWeatherBar)
    cc.bar.r.should == '1026.1'
    cc.bar.d.should == 'steady'
  end
  
  it "should parse wind xml data" do
    cc = RWeatherCurrentCondition.parse(@xml_data)
    cc.wind.should be_kind_of(RWeatherWind)
    cc.wind.s.should == '11'
    cc.wind.gust.should == 'N/A'
    cc.wind.d.should == '50'
    cc.wind.t.should == 'NE'
  end
  
  it "should parse uv xml data" do
    cc = RWeatherCurrentCondition.parse(@xml_data)
    cc.uv.should be_kind_of(RWeatherUv)
    cc.uv.i.should == '2'
    cc.uv.t.should == 'Low'
  end
  
  it "should parse moon xml data" do
    cc = RWeatherCurrentCondition.parse(@xml_data)
    cc.moon.should be_kind_of(RWeatherMoon)
    cc.moon.icon.should == '18'
    cc.moon.t.should == 'Waning Gibbous'
  end
  
end