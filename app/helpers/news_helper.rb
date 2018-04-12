module NewsHelper
  def sort_link(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
    icon = sort_direction == 'asc' ? 'fas fa-arrow-up' : 'fas fa-arrow-down'
    icon = column == sort_column ? icon : ''
    link_to "#{title} <span class='#{icon}'></span>".html_safe, {column: column, direction: direction}
  end

  def date_for_news(date)
    date.blank? ? nil : date.strftime('%m/%d/%Y')
  end

  def date_time_for_news(date)
    date.blank? ? nil : date.strftime('%Y-%m-%d %H:%M')
  end
end
