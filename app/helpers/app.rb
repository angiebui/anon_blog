helpers do
  # If @title is assigned, add it to the page's title.
  def title
    if @title
      "#{@title} -- Angie's Blog" 
    else
     "Angie's Blog"
    end
  end

  def format_date(time)
   time.strftime("%d %b %Y")
  end


  def tag_names(post_id)
    tag_ids = find_tag_ids(post_id)
    tag_ids.map {|id| Tag.find_by_id(id).name} # will be an array of names ["Food", "Misc"]
  end

  def find_tag_ids(post_id)
    post_tags = PostTag.where("post_id = ?", post_id)
    post_tags.map {|e| e.tag_id} # will be in an array [3, 2] 
  end
end 




