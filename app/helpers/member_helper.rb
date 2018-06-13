require 'csv'

module MemberHelper
  def sort_link(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
    icon = sort_direction == 'asc' ? 'glyphicon glyphicon-chevron-up' : 'glyphicon glyphicon-chevron-down'
    icon = column == sort_column ? icon : ''
    link_to "#{title} <span class='#{icon}'></span>".html_safe, column: column, direction: direction
  end

  def csv_member_list
    columns = %w[name address city state zip phone]
    CSV.generate(col_sep: ';',
                 row_sep: "\n",
                 headers: true,
                 write_headers: true,
                 return_headers: true) do |csv|
      csv << %w[Name Address City State Zip Phone]
      Member.find_each.each do |member|
        csv << columns.collect { |name| member.send(name) }
      end
    end
  end
end