Gem::Specification.new do |s|
  s.name     = "rweather"
  s.version  = "0.1"
  s.date     = "2008-09-06"
  s.summary  = "Ruby gem to access Weather Channel (weather.com) XML API."
  s.email    = "ckozus@gmail.com"
  s.homepage = "http://github.com/ckozus/rweather"
  s.description = "This gems lets you access to the search and get current conditions features."
  s.has_rdoc = true
  s.authors  = ["Carlos Kozuszko"]
  s.files    = ["lib/r_weather.rb", "lib/r_weather_current_condition.rb", "spec/current_condition.xml", "spec/r_weather_current_condition_spec.rb"]
  s.rdoc_options = ["--main", "README"]
  s.extra_rdoc_files = ["README"]
  s.add_dependency("xml-simple", [">= 1.0.11"])
end
