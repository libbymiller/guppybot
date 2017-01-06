require 'open-uri'
require 'nokogiri'
require 'pp'

def anyonein()
      url = "http://bristol.hackspace.org.uk/anyonein/"
      open(url) {|f|
        f.each_line {|line| 
          if(re = line.match(/(Someone moved .*)</))
            p re[1]
          end
        }
      }
end   

anyonein
