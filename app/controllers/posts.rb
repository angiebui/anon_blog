get '/post/new' do
  erb :new
end

post '/post' do
  @post = Post.new(:title => params[:title], :body => params[:body])
  tags = check_tags(params[:tags].split(", "))
  @post.tags << tags 
  
  if @post.save 
    redirect "post/#{@post.id}"
  else
    @errors = @post.errors.full_messages
    erb :new
  end
end

get '/post/:id' do 
  @post = Post.where("id = ?", params[:id]).first
  if @post 
    @title = @post.title
    erb :post
  else
    @errors = "Post not found."
    erb :error
  end
end

get "/post/:id/edit" do
  @post = Post.find(params[:id])
  @title = "Edit Post"
  erb :edit
end

put "/post/:id" do
  @post = Post.find(params[:id])
  updated = update_tags(@post, (params[:tags].split(", ")))
  @post.tags << updated
  @post.update_attributes(:title => params[:title], :body => params[:body])

  if @post.save
    redirect "/post/#{@post.id}"
  else
    @errors = @post.errors.full_messages
    erb :edit
  end
end

delete "/post/:id" do
  @post = Post.find(params[:id]).destroy
  redirect "/"
end
