require 'sinatra'
require 'sinatra/reloader' if development?
require 'inflect'
require 'pry'

get '/' do
  erb :index
end

post '/handle' do
  param = params['word'].upcase
  content = Inflect.handle([param]).content

  erb :response, locals: { content: content }
end