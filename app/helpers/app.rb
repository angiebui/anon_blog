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

  def update_tags(post, tags)
    tags_to_delete = (post.tags.map{|tag| tag.name}) & tags 
    if tags_to_delete != []
      delete_ids = tags_to_delete.map {|tag| Tag.find_by_name(tag).id}.uniq
      delete_ids.map {|id| PostTag.find_by_post_id_and_tag_id(post.id, id)}.each {|post_tag| post_tag.destroy.save}
    end

    check_tags((post.tags.map{|tag| tag.name}) - tags)
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

  def home_page
    request.path_info =~ /\//
  end
end 




