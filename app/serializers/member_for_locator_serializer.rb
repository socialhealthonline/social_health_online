class MemberForLocatorSerializer < ActiveModel::Serializer
  attributes :name, :address, :city, :zip, :url, :phone, :full_address, :state

  # def state
  #   US_STATES.key(object.state)
  # end

  def phone
    object.phone
  end
end
