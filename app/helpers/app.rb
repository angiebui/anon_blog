helpers do
  def format_date(time)
   time.strftime("%d %b %Y")
  end

  def tag_names(tags) #tag objects
    names = tags.map {|tag| tag.name}.join(', ')
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

end 




