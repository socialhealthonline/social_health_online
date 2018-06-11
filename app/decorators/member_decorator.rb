class MemberDecorator < ApplicationDecorator
  delegate_all
  include Draper::LazyHelpers

  def logo
    params = { class: 'c-pointer', data: { toggle: 'modal', target: '#community-profile-modal' } }
    if object.logo.attached? && object.logo.attachment.valid?
      params[:alt] = 'Community logo'
      image_tag object.logo.variant(resize: '160x160'), params
    else
      params[:alt] = 'Default logo'
      image_tag 'default-logo.png', params
    end
  end

end
