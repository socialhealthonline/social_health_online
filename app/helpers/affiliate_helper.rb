# frozen_string_literal: true

require 'csv'

module AffiliateHelper
  def support_types
    Affiliate.support_types
  end

  def csv_affilialate_list
    columns = %w[name address city state zip phone url]
    CSV.generate(col_sep: ';',
                 row_sep: "\r\n",
                 headers: true,
                 write_headers: true,
                 return_headers: true) do |csv|
      csv << %w[Name Address City State Zip Phone URL]
      Affiliate.all.each do |affiliate|
        csv << columns.collect { |name| affiliate.send(name) }
      end
    end
  end
end
