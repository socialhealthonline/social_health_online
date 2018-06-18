class AffiliateForLocatorSerializer < ActiveModel::Serializer
  attributes :name, :address, :city, :zip, :url, :phone, :support_type, :full_address, :state, :support_notes
  include ActionView::Helpers
  def support_type
    Affiliate::SUPPORT_TYPES[object.support_type]
  end

  def phone
    number_to_phone object.phone
  end  

  # def state
  #   US_STATES.key(object.state)
  # end
end
