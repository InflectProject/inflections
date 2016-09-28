require 'pry'
require 'sinatra'
require 'sinatra/json'
require 'sinatra/reloader'
require 'dotenv'
require 'inflect'
require './helpers'

require 'sinatra/cross_origin'

#configure do
#  enable :cross_origin
#end

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
  words = params['words'].map(&:upcase)
  inflections = Inflect.handle(words)

  json inflections.to_hash
end
