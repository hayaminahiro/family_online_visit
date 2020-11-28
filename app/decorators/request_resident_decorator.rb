# frozen_string_literal: true

module RequestResidentDecorator
  def approval_status
    req_approval == "承認済" ? tag.span(req_approval, style: 'color: #e41414;') : tag.span(req_approval, style: 'color: #a2b9ca;')
  end
end
