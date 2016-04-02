require 'sinatra'
require 'sinatra/reloader' if development?
require 'inflect'
require 'pry'

get '/demo' do
  erb :demo
end

post '/handle' do
  param = params['word'].upcase
  content = Inflect.handle([param]).content

  erb :demo, locals: { content: content }
end