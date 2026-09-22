require 'sinatra'
require 'sinatra/reloader' if development?

set :public_folder, File.join(__dir__, 'public')
set :views, File.join(__dir__, 'views')

get '/' do
  erb :index
end

get '/health' do
  content_type :json
  '{"status":"ok"}'
end
