# frozen_string_literal: true

module RequestResidentDecorator
  def approval_status
    req_approval == "承認済" ? tag.span(req_approval, style: 'color: #e41414;') : tag.span(req_approval, style: 'color: #a2b9ca;')
  end

  def approval_link(request, facility)
    case req_approval
    when "申請中"
      tag.p((link_to "利用者登録は #{request.req_approval} です", edit_request_resident_path(request), class: "btn-shine"))
    when "承認済"
      tag.p((link_to "利用者登録は #{request.req_approval} です", new_request_resident_path(facility_id: facility), class: "btn-shine"))
    else
      tag.p((link_to "ご利用者様の登録申請", new_request_resident_path(facility_id: facility), class: "btn-shine"))
    end
  end
end
