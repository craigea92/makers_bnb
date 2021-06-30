require 'sinatra/base'
# require 'sinatra/flash'
require 'sinatra/reloader'
require './lib/user'
require './lib/space'
require './database_connection_setup'

class MakersBnB < Sinatra::Base 
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions

  get '/' do
    erb(:'index') 
  end 

 
  post '/sign_up' do
    # if params[:password_one] != params[:password_two]
    User.sign_up(name: params[:name], email: params[:email], password: params[:password_one])
    redirect '/spaces'
  end 

  get '/sign_in' do
    erb :'sign_in'
  end

  post '/sign_in' do
    redirect '/spaces'
  end
  
  get '/addnewspace' do
    erb :new_space
  end

  post '/new_space' do
    Space.create(name: params[:name], description: params[:description], price: params[:price], date_avail: params[:date_avail])
    redirect '/spaces'
  end

  get '/spaces' do
    @space = Space.all
    erb :spaces
  end

  post '/date_range' do
    p params[:date_range]
    Space.filter(date_avail: params[:date_avail]) 
    redirect '/spaces_filtered'
  end

  get '/spaces_filtered' do
    p params[:date_range]
    @space = Space.filter(date_avail: params[:date_avail]) 
    erb :spaces_filtered
  end

  run! if app_file == $0

end