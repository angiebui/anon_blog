helpers do
  def format_date(time)
   time.strftime("%d %b %Y")
 end

  def tag_names(tags) #tag objects
    names = tags.map {|tag| tag.name}
  end

  def check_tags(tag_names)
    tag_names.map {|name| check_tag(name) }
  end

  def check_tag(tag_name)
    tag = Tag.find_or_create_by_name(tag_name)
    tag unless nil 
  end

  def get_posts(tag_name)
    Tag.find_by_name(tag_name).posts
  end

  def update_tags(post, new_tags)
    PostTag.delete_all("post_id = #{post.id}") if new_tags.empty? 
    old_tags = post.tags.map{|tag| tag.name}

    updated = []
    updated << (new_tags - old_tags)
    updated << (new_tags & old_tags)

    deleted_tags = (old_tags - (updated.flatten))
    ids = deleted_tags.map {|tag| Tag.find_by_name(tag).id}
    ids.map {|tag_id| PostTag.delete_all("post_id = #{post.id} and tag_id = #{tag_id}")}

    tags_to_create = filter_tags(post, updated.flatten)
    create_tags(tags_to_create).compact
  end

  # bug - can't add a tag that has already been created. need to append it. 
  # issue might be because of the new_item.save part. 

  def filter_tags(post, tag_names)
    tag_names.map do |name|
      name unless post.tags.find_by_name(name)
    end
  end

  def create_tags(array)
    array.map do |item|
      new_item = Tag.new(:name => item)
      new_item if new_item.save 
    end
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




