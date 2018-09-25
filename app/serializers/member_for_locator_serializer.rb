class MemberForLocatorSerializer < ActiveModel::Serializer
  attributes :name, :address, :city, :zip, :url, :phone, :full_address, :state, :org_type
  include ActionView::Helpers
  # def state
  #   US_STATES.key(object.state)
  # end

  def phone
    number_to_phone object.phone
  end

  def url
    object.url.blank? ? "" : link_to(object.url, object.url, target: "_blank")
  end

end
