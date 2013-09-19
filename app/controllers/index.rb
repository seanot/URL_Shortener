get '/' do
  @urls = Url.all
  
  erb :index
end 


get '/secret_page/:id' do
  if session[:id] 
    @urls = Url.where(user_id: session[:id])
    erb :secret
  else
    redirect to ('/create_user')
  end
end

get '/logout' do
  session.clear
  erb :create
end

get '/create_user' do
  erb :create
end

get '/:short_url' do
  @url = Url.where("short_url = '#{params[:short_url]}'").first
  @url.count_up
  redirect to (@url.long_url)

end
#=====POST===================

post '/urls' do
  # Save the new url
  # If successful, redirect back to home page
  # Else, handle error

  url = Url.random_generator
  short_url = Url.new(long_url: params[:long_url], short_url: url, user_id: session[:id])

  if short_url.save
    @url_1 = "http://localhost:9393/" + url
    
    redirect to ("/")
  else
    erb :index
  end
end

post '/create_user' do
  email = params[:email]
  password = params[:password]
  @current_user = User.new(email: email, password: password)
  if @current_user.save
    session[:id] = @current_user.id
    redirect to ('/secret_page')
  else 
    erb :create
  end
end

post '/login' do

  email = params[:email]
  password = params[:password]
  @sample = User.find_by_email(email)
  if @sample 
    @user = User.authenticate(email, password)
    if @user 
      session[:id] = @user.id
      redirect to ("/secret_page/#{session[:id]}")
    else 
      redirect to ('/')
    end
  else
    redirect to ('/')
  end
end
