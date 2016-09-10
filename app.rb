require 'pry'
require 'sinatra'
require 'sinatra/json'
require 'sinatra/reloader'
require 'dotenv'
require 'inflect'
require './helpers'

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
  words = params['words'].map(&:upcase)
  inflections = Inflect.handle(words)

  json inflections.to_hash
end
