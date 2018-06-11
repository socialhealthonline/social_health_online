class UserDecorator < ApplicationDecorator
  delegate_all

  def user_pending?(f)
    params = { include_blank: false, class: "form-control custom-select #{object.errors[:user_status].present?  ? 'is-invalid' : nil}" }
    if object.pending?
      params.merge!(disabled: true)
      f.select(:user_status, ['Pending'], {}, params)
    else
      f.select(:user_status, ['activated', 'disabled'], {}, params)
    end
  end

  def user_manager?
    if user.manager?
      h.content_tag :i, '', class: "fa fa-check"
    else
      h.content_tag :strong, 'X'
    end
  end
end
