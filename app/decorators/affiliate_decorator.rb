class AffiliateDecorator < ApplicationDecorator
  delegate_all
  include Draper::LazyHelpers

  def logo
    if object.logo.attached? && object.logo.attachment.valid?
      image_tag object.logo.variant(resize: '200x200'), class: 'c-pointer', alt: 'Affiliate Logo',
                data: { toggle: 'modal', target: '#community-profile-modal' }
    end
  end

end
