class EventDecorator < Draper::Decorator
  delegate_all
  include Draper::LazyHelpers
  include Rails.application.routes.url_helpers

  def logo
    if object.logo.attached? && object.logo.attachment.valid?
      image_tag object.logo, alt: 'Event Logo', size: '200x200'
    end
  end

  def link_or_span(value, rsvp_switcher)
    if object.rsvp_limit_reached? && rsvp_switcher&.rsvp_status != 'yes'
      h.content_tag :span, value.capitalize, class: "dropdown-item events-flash"
    else
      h.link_to value.capitalize, create_or_switch_rsvp_community_event_path(object.member, object, event: value), class: 'dropdown-item', method: :post
    end
  end
end
