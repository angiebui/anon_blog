# Get the new post form 

get '/post/new' do

  erb :new
end


post '/post' do
  @post = Post.new(params[:post])
  if @post.save 
    redirect "post/#{@post.id}"
  else
    erb :new
  end
end

# Get the individual post with this ID

get '/post/:id' do
  @post = Post.find(params[:id])

  erb :post
end
