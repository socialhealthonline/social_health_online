class Resource < ApplicationRecord
validates :name, :state, presence: true

before_validation :add_protocol_to_url

end

private

def add_protocol_to_url
  self.url = "http://#{url}" if url.present? && url !~ /\Ahttp/
end
