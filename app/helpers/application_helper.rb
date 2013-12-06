module ApplicationHelper

# Returns the full title on a per-page basis.
  def full_title(page_title)
  base_title = "Stephane's New App"
	if page_title.empty?
	  base_title
	else
	  "#{base_title} | #{page_title}"
	end
  end

# Returns a tag clouds with the categories of lessons.
  def tag_cloud(tags, classes)
    max = 0
    tags.each do |t|
      if t.count.to_i > max
        max = t.count.to_i
      end 
    end
    tags.each do |tag|
      index = tag.count.to_f / max * (classes.size - 1)
      yield(tag, classes[index.round])
    end
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = (column == sort_column) ? "current #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end
end
