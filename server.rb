require 'colorize'
require 'json'
require 'awesome_print'
require 'thread/pool'
require 'sinatra'
require 'redis'

def find_matches(line)
  redis = Redis.new
  cached_data = redis.get(line)
  if cached_data
    puts "CACHE HIT!".green
    return JSON.parse(cached_data)
  end

  output = `export JAVA_HOME=/usr/lib/jvm/java-7-oracle && pig -param "line='#{line}'" -x mapreduce search.pig`

  links = []
  output.each_line {|line|
    /\((?<line_number>\d+),(?<file_name>.+?),(?<sentence>.+?)\)$/ =~ line
    link = { file_name: file_name, line_number: line_number.to_i }
    links << link
  }

  redis.set(line, links.to_json)
  return links
end

def search(input)
  pool = Thread.pool(10)

  result = []

  input.split('\n').each_with_index {|raw_line, input_line_number|
    line = raw_line.chomp
    pool.process {
      matching = {line: line, matches: find_matches(line)}
      result[input_line_number] = matching
    }
  }

  pool.shutdown
  # ap result
  return result
end

set :bind, '0.0.0.0'
set :port, '8080'

get '/' do
  'SERVER IS RUNNING<br>TRY /search?q=hello'
end

get '/search' do
  search(params['q']).to_json
end