# frozen_string_literal: true

module RequestResidentDecorator
  def status
    case req_approval
    when "承認済"
      tag.span(req_approval, style: 'color: #e41414;')
    when "否認済"
      tag.span(req_approval, style: 'color: #0c94f9;')
    else
      tag.span(req_approval, style: 'color: #a2b9ca;')
    end
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
