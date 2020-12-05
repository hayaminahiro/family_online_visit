# frozen_string_literal: true

module RequestResidentDecorator
  def status
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

  def user_name
    if id == RequestResident.order(id: :desc).where(facility_id: current_facility).find_by(user_id: user_id).id
      tag.p((link_to user.name, edit_relative_path(id), class: "is-small is-size-6", style: "width: 45%;"))
    else
      user.name
    end
  end
end
