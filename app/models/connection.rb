class Connection < ApplicationRecord
belongs_to :member
validates :name, :url, presence: true
before_validation :add_protocol_to_url

end

private

def add_protocol_to_url
  self.url = "http://#{url}" if url.present? && url !~ /\Ahttp/
end
