Gem::Specification.new do |s|
  s.name        = 'ESDumpSource'
  s.version     = '1.0.1'
  s.date        = '2014-09-02'
  s.summary     = "library that allows to dumps indice or indice/type elasticsearch content"
  s.description = "library that allows to dumps indice or indice/type elasticsearch content"
  s.authors     = ["Jean-Bernard Damiano"]
  s.email       = 'jbdamiano@gmail.com'
  s.files       = ["lib/es_dump_source.rb"]
  s.homepage    =
    'https://github.com/gouketsu/elasticsearch_dump_source'
  s.add_dependency 'json', "~>1.5.5"
  s.add_dependency 'rest-client', "~>1.6.7"
  end
