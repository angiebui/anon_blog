helpers do
  def format_date(time)
   time.strftime("%d %b %Y")
  end

  def tag_names(tags) #tag objects
    names = tags.map {|tag| tag.name}
  end

  def check_tags(tags)
    tags.map {|tag_name| check_tag(tag_name) }
  end

  def check_tag(tag_name)
    tag = Tag.find_or_create_by_name(tag_name)
    tag.valid? ? tag : nil 
  end

  def get_posts(tag_name)
    Tag.find_by_name(tag_name).posts
  end

  def post_show_page?
    request.path_info =~ /\/post\/\d+$/
  end

  def delete_post_button(post_id)
    erb :_delete_post_button, locals: { post_id: post_id}
  end

  def new_post_page
    request.path_info =~ /\/post\/new/
  end

  def home
    request.path_info =~ /\//
  end
end 




