get '/tag/:tag_name' do
  @tag_name = params[:tag_name]
  if @posts = get_posts(@tag_name)
  	erb :tags 
  else
  	@errors = "Tag not found"
  	erb :error
  end
end

