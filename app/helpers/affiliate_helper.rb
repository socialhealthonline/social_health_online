# frozen_string_literal: true

require 'csv'

module AffiliateHelper
  def sort_link(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
    icon = sort_direction == 'asc' ? 'fas fa-arrow-up' : 'fas fa-arrow-down'
    icon = column == sort_column ? icon : ''
    link_to "#{title} <span class='#{icon}'></span>".html_safe, {column: column, direction: direction}
  end

  def support_types
    Affiliate.support_types
  end

  def csv_affiliate_list
    columns = %w[name address city state zip phone url support_type org_type]
    CSV.generate(col_sep: ';',
                 row_sep: "\n",
                 headers: true,
                 write_headers: true,
                 return_headers: true) do |csv|
      csv << %w[Affiliate\ Name Address City State Zip Phone URL Support\ Type Org\ Type]
      Affiliate.find_each do |affiliate|
        csv << columns.collect { |name| affiliate.send(name) }
      end
    end
  end
end
