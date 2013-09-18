get '/' do
  # Look in app/views/index.erb
  erb :index
end 

get '/:short_url' do
  @url = Url.where("short_url = '#{params[:short_url]}'").first
  redirect to (@url.long_url)
end


#=====POST===================

post '/urls' do

  url = Url.random_generator
  short_url = Url.new(long_url: params[:long_url], short_url: url)
  if short_url.save
    redirect to('/')
  else
    erb :index
  end
end
