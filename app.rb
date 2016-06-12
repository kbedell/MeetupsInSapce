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
  erb :'meetups/new'
end

get '/meetups/:id' do
  id = params["id"]
  @display_form = false
  @message = "You must be signed in and a member of this meetup to make a comment."
  @meetup = Meetup.find(id)
  @members = Member.where(meetup_id: id)
  @user_ids = []
  @members.each do |member|
    @user_ids << member.user_id
  end
  @comments = []

  Comment.find_each do |comment|
    if @user_ids.include?(comment.user_id) && comment.meetup_id == @meetup.id
      @comments << comment
    end
  end

  if current_user
    @display_form = true
  end
  erb :'meetups/show'
end

post '/comment/:meetup_id' do
  new_comment = Comment.new(body: params[:body], user_id: current_user.id, meetup_id: Meetup.find(params[:meetup_id].to_i).id)
  if new_comment.valid?
    new_comment.save
    redirect "/meetups/#{params[:meetup_id]}"
  else
    flash[:notice] = "The comment was not saved."
    redirect "/meetups/#{params[:meetup_id]}"
  end
end
