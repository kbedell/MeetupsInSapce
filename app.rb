require 'sinatra'
require_relative 'config/application'
require 'pry'

helpers do
  def current_user
    if @current_user.nil? && session[:user_id]
      @current_user = User.find_by(id: session[:user_id])
      session[:user_id] = nil unless @current_user
    end
    @current_user
  end
end

get '/' do
  redirect '/meetups'
end

get '/auth/github/callback' do
  user = User.find_or_create_from_omniauth(env['omniauth.auth'])
  session[:user_id] = user.id
  flash[:notice] = "You're now signed in as #{user.username}!"

  redirect '/'
end

get '/sign_out' do
  session[:user_id] = nil
  flash[:notice] = "You have been signed out."

  redirect '/'
end

get '/meetups' do
  @meetups = Meetup.all.order(:name)

  erb :'meetups/index'
end

get '/meetups/new' do
  if current_user
    @errors = []
    erb :'meetups/new'
  else
    flash[:notice] = "You need to be signed in to create a new meetup"
    redirect '/meetups'
  end
end

post '/meetups/new' do
  if current_user
    m = Meetup.create(name: params[:name], description: params[:description], location: params[:location])

    if m.valid?
      Member.create(user_id: current_user.id, meetup_id: m.id, creator: true)
      id = m.id
      flash[:notice] = "You have successfully created a new meetup"
      redirect "/meetups/#{id}"
    else
      @name = params[:name]
      @description = params[:description]
      @location = params[:location]
      @errors = m.errors.full_messages

      erb :'meetups/new'

    end
  else
    flash[:notice] = "You need to be signed in to create a new meetup"
    redirect "/meetups"
  end
end

get '/meetups/:id' do
  id = params["id"]
  @meetup = Meetup.find(id)
  @members = Member.where(meetup_id: id)

  erb :'meetups/show'
end

post '/meetups/:id' do
  if current_user
    id = params["id"]
    Member.create(user_id: current_user.id, meetup_id: id)
    flash[:notice] = "You successfully joined the meetup"
    redirect "/meetups/#{id}"

  else
    id = params["id"]
    flash[:notice] = "You need to be signed in to join a meetup"
    redirect "/meetups/#{id}"
  end
end
