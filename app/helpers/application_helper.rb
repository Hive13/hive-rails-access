module ApplicationHelper

  def title
    base_title = "HIVE13 Badging System"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  def logo
    image_tag("logo.png", :alt => "Sample App", :class => "round")
  end

end
