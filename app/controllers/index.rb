# index route displaying your homepage 

get '/' do
  @posts = Post.order("created_at DESC")
  erb :index
end
