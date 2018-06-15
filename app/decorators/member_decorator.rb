class MemberDecorator < ApplicationDecorator
  delegate_all
  include Draper::LazyHelpers

  def logo
    if object.logo.attached? && object.logo.attachment.valid?
      image_tag object.logo.variant(resize: '160x160'), class: 'c-pointer', alt: 'Community logo',
                data: { toggle: 'modal', target: '#community-profile-modal' }
    end
  end

end
