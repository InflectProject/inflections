require 'sinatra'
require 'dotenv'
require 'pry'

require 'sinatra/reloader' if development?
require 'inflect'
require 'pry'
require 'json'

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