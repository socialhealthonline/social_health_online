module ApplicationHelper

  def page_title(page_title)
    content_for(:title) { page_title }
  end

  def active_nav(nav_item)
    if controller_name == 'public'
      action_name == nav_item ? 'active' : nil
    else
      controller_name == nav_item ? 'active' : nil
    end
  end

  def bootstrap_class_for(flash_type)
    { success: 'alert-success', error: 'alert-danger', warning: 'alert-warning', info: 'alert-info' }[flash_type.to_sym] || flash_type.to_s
  end

  def model_error_display(model, attribute)
    if field_with_error?(model, attribute)
      content_tag(:small, "#{model.errors[attribute].first}", class: 'text-danger')
    end
  end

  def field_with_error?(model, attribute)
    model.errors[attribute].present?
  end

  def form_error_class(model, attribute)
    field_with_error?(model, attribute) ? 'is-invalid' : nil
  end

  def short_date(date)
    date.blank? ? nil : date.strftime('%Y-%m-%d')
  end

  def short_date_time(datetime, time_zone)
    datetime.blank? ? nil : datetime.in_time_zone(time_zone).strftime('%b %d %Y, %l:%M %p %Z')
  end

end
