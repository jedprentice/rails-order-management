# Allows us to test posts of JSON data
require 'net/http'
require 'optparse'
require 'json'

BASE_URI = 'http://localhost:3000'

def usage
  "Usage: #{__FILE__} [options] verb path"
end

# Parses the command line options
def parse_opts
  option_parser = OptionParser.new do |opts|
    opts.banner = usage()
    opts.on('-h', '--help', 'Display this screen') do
      puts opts
      exit
    end
  end

  option_parser.parse!
  if ARGV.length < 2
    print "#{usage()}\n"
    exit
  end
end

def request(verb, path, data)
  uri = URI("#{BASE_URI}#{path}")
  puts "verb: #{verb}"
  puts "uri: #{uri}"
  puts "data:#{data}"

  class_name = verb.capitalize
  request = Net::HTTP.const_get(class_name).new(uri.path)
  request.content_type = 'application/json'
  request.body = data.to_json

  Net::HTTP.start(uri.host, uri.port) do |http|
    http.request(request)
  end
end

parse_opts
response = request(ARGV[0], ARGV[1], {:name => 'test create', :price => 1.99})
puts response.body
