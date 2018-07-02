class MemberForLocatorSerializer < ActiveModel::Serializer
  attributes :name, :address, :city, :zip, :url, :phone, :full_address, :state
  include ActionView::Helpers
  # def state
  #   US_STATES.key(object.state)
  # end

  def phone
    number_to_phone object.phone
  end
end
