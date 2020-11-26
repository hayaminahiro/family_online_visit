# frozen_string_literal: true

module RequestResidentDecorator
  def approval_status
    if req_approval == "承認済"
      "<span style= 'color: #e41414;'>#{req_approval}</span>".html_safe
    else
      "<span style= 'color: #a2b9ca;'>#{req_approval}</span>".html_safe
    end
  end
end
