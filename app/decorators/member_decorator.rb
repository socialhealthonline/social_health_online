class MemberDecorator < ApplicationDecorator
  delegate_all
  include Draper::LazyHelpers

  def logo
    if object.logo.attached? && object.logo.attachment.valid?
      image_tag object.logo.variant(resize: '200x200'), class: 'c-pointer', alt: 'Community Logo',
                data: { toggle: 'modal', target: '#community-profile-modal' }
    end
  end

end
