# frozen_string_literal: true

##
module ApplicationHelper
  def login_helper
    if current_user.is_a?(User)
      link_to 'Logout', destroy_user_session_path, method: :delete
    else
      (link_to 'Login', new_user_session_path) +
        '<br>'.html_safe +
        (link_to 'Signup', new_user_registration_path)
    end
  end

  def flash_class(level)
    case level
    when 'notice' then 'alert alert-success'
    when 'success' then 'alert alert-success'
    when 'error' then 'alert alert-danger'
    when 'alert' then 'alert alert-danger'
    end
  end
end
