get '/post/new' do
  
  erb :new
end

post '/post' do
  @post = Post.new(:title => params[:title], :body => params[:body])
  tags = check_tags(params[:tags].split(","))
  @post.tags << tags 
  
  if @post.save 
    redirect "post/#{@post.id}"
  else
    @errors = @post.errors.full_messages
    erb :new
  end
end


get '/post/:id' do
  @post = Post.find(params[:id])
  @title = @post.title
  erb :post
end


get "/post/:id/edit" do
  @post = Post.find(params[:id])
  @title = "Edit Post"
  erb :edit
end

put "/post/:id" do
  @post = Post.find(params[:id])
  tags = check_tags(params[:tags].split(","))
  @post.tags << tags 

  if @post.update_attributes!(:title => params[:title], :body => params[:body])
    redirect "/posts/#{@post.id}"
  else
    @errors = @post.errors.full_messages
    erb :edit
  end
end

delete "/post/:id" do
  @post = Post.find(params[:id]).destroy
  redirect "/"
end
