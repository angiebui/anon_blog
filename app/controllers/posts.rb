# Get the new post form 

get '/post/new' do

  erb :new
end


post '/post' do
  tag = check_tag(params[:tag])
  @post = Post.new(:title => params[:title], :body => params[:body])
  @post.tags << tag if tag.valid?

  if @post.save 
    redirect "post/#{@post.id}"
  else
    @errors = @post.errors.full_messages
    erb :new
  end
end

# Get the individual post with this ID

get '/post/:id' do
  @post = Post.find(params[:id])

  erb :post
end
