class AffiliateForLocatorSerializer < ActiveModel::Serializer
  attributes :name, :address, :city, :zip, :url, :phone, :support_type, :full_address, :state

  def support_type
    Affiliate::SUPPORT_TYPES[object.support_type]
  end

  def state
    US_STATES.key(object.state)
  end
end
