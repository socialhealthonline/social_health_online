require 'csv'

module UserHelper
  def sort_link(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
    icon = sort_direction == 'asc' ? 'fas fa-arrow-up' : 'fas fa-arrow-down'
    icon = column == sort_column ? icon : ''
    link_to "#{title} <span class='#{icon}'></span>".html_safe, {column: column, direction: direction}
  end

  def csv_user_list
    columns = %w[name display_name city state zip phone email]
    CSV.generate(col_sep: ';',
                 row_sep: "\n",
                 headers: true,
                 write_headers: true,
                 return_headers: true) do |csv|
      csv << %w[Name Display Name Address City State Zip Phone Email]
      User.find_each do |user|
        csv << columns.collect { |name| user.send(name) }
      end
    end
  end
end
