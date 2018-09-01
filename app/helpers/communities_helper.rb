require 'csv'

module CommunitiesHelper
  def sort_link(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
    icon = sort_direction == 'asc' ? 'fas fa-arrow-up' : 'fas fa-arrow-down'
    icon = column == sort_column ? icon : ''
    link_to "#{name} <span class='#{icon}'></span>".html_safe, {column: column, direction: direction}
  end

  def csv_member_user_list
    columns = %w[name display_name email phone address city state zip user_status total_social_events_logged last_social_event_log_date]
    CSV.generate(col_sep: ';',
                 row_sep: "\n",
                 headers: true,
                 write_headers: true,
                 return_headers: true) do |csv|
      csv << %w[Name Display\ Name Email Phone Address City State Zip Status Total\ Events\ Logged Last\ Logged\ Event]
      User.where(member_id: authenticated_user.member.id).find_each do |user|
        csv << columns.collect { |name| user.send(name) }
      end
    end
  end
end
