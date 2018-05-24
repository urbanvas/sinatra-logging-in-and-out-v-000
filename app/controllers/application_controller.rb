require_relative '../../config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  post '/login' do
    @user = User.find_by(username: params[:username], password: params[:password])
    if @user != nil
      session[:user_id] = @user.id
      redirect to '/account'
    else
      erb :error
    end

  end

  get '/account' do
    @user = User.find_by_id(session[:user_id])
    if @user
      erb :account
    else
      erb :error
  end

  get '/logout' do
    sesion.clear
    redirect to '/'
  end


end
