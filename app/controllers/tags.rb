# tag-related routes will go to tags controller 

get '/tag/:tag_name' do
  @tag_name = params[:tag_name]
  @posts = get_posts(@tag_name)
  erb :tags 
end
