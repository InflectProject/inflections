require 'pry'
require 'sinatra'
require 'sinatra/json'
require 'sinatra/reloader'
require 'dotenv'
require 'inflect'
require './helpers'

require 'sinatra/cross_origin'

#http://stackoverflow.com/a/4352077/4317329
before do
  if request.request_method == 'OPTIONS'
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Methods"] = "POST"
    response.headers["Access-Control-Allow-Headers"] = "Content-Type, Accept, Access-Control-Allow-Headers, Authorization, X-Requested-With"

    halt 200
  end
end

set :public_folder, Proc.new { File.join(root, "dist") }

get '/' do
  File.read('dist/index.html')
end

get '/wit/:message' do
  response = Inflect.handle(['WIT', 'MESSAGE', params['message']])
  json response.to_hash
end

# This is are the test routes for a more
# graphical sample of the app's behaviour
get '/demo' do
  erb :demo
end

post '/handle' do
  param = params['word'].upcase
  begin
    inflection = Inflect.handle([param])
  rescue Exception => e
    erb :error, locals: { error: e.message }
  end

  erb :demo, locals: { inflection: inflection }
end

post '/inflect' do
  cross_origin
  words = JSON.parse(request.body.read)['words'].map(&:upcase)
  inflections = Inflect.handle(words)

  json inflections.to_hash
end
