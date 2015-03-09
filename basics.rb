require 'rubygems'
require 'sinatra'

post '/' do
	'You said #{params[:message]}'
end

get '/secret' do
	erb :'secrets'
end

post '/secret' do
	params[:secret].reverse
end

not_found do
	status 404
	File.read(File.join('views', '9GAG.html'))
end