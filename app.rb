require 'sinatra'
require 'sinatra/reloader' if development?
require 'inflect'
require 'pry'
require 'json'

get '/demo' do
  erb :demo
end

post '/handle' do
  param = params['word'].upcase
  begin
    content = Inflect.handle([param]).content
  rescue Exception => e
    erb :error, locals: { error: e.message }
  end

  erb :demo, locals: { content: content }
end