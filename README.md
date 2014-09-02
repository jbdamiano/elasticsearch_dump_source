elasticsearch_dump_source
=========================

Library that allow to dump all _source for an indice or indice/type from elasticsearch

attribute
---------
* pattern: name of indice or indice/type
* scroll_time: time that scrol will be keep 1m by default (accessor write)
* size: returned size by scroll request 50 by default (accessor write)
* host: elasticsearch host localhost by default (accessor write)
* port: elasticsearch port 9200 by default (accessor write)

return
------
Library return a json data
if an error occured the json contains the field "error"
otherwhise it contains all data

Exemple
=======

    # encoding: UTF-8
    # coding: UTF-8
    # -*- coding: UTF-8 -*-
    require 'rest_client'
    require 'json'
    require 'es_dump_source'

    def usage
      puts "#{File.basename(__FILE__)} <alias|indice>"
    end

    if ARGV.length != 1
      usage
      exit 1
    end
    pattern = ARGV[0]

    dump_source = ESDumpSource.new(pattern)
    puts dump_source.retrieve_data
