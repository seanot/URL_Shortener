get '/' do
  # Look in app/views/index.erb

  # Grab all of the URLs, saving them to an instance variable
  # Iterate over them to display their values in the view
  @urls = Url.all
  
  erb :index
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
  short_url = Url.new(long_url: params[:long_url], short_url: url)

  if short_url.save
    @url_1 = "http://localhost:9393/" + url
    
    redirect to ("/")
  else
    erb :index
  end
end
