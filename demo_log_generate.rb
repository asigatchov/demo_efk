
#require 'date'

log = File.open('./data/access.log', "w")
IO.popen("zcat data/my.access.log.1.gz").each do |f|
  log.write ( f.gsub(%r{\[\d+/Dec/2016}, Time.now.strftime("[%d/%b/%Y")))
  sleep 0.0009
end
