require 'sinatra'
require 'sinatra/activerecord'

db = URI.parse('mysql://root:password@localhost:3306/sinatra')

ActiveRecord::Base.establish_connection(
  :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
  :host     => db.host,
  :username => db.user,
  :password => db.password,
  :database => db.path[1..-1],
  :encoding => 'utf8'
)

class User < ActiveRecord::Base
end

get '/' do
	haml :index
end

post '/' do
	username = params[:name]
	password = params[:password]

	# or user = User.where() and user.present?
	if User.where(:username => username, :password => password).exists?
		'Access granted'
	else
		'Access denied'
	end
end

get '/signup' do
	haml :signup
end

post '/signup' do
	username = params[:username]
	password = params[:password]
	repeatPassword = params[:repeatPassword]

	if (password.eql? repeatPassword)
		user = User.new(username: username, password: password)
		user.save
		'Succeed'
	elsif User.where(:username => username).exists?
		'User signup failed, name already taken'
	else 
		'Passwords not fit, confirm password again.'
	end
end