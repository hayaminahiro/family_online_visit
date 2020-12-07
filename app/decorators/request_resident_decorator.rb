# frozen_string_literal: true

module RequestResidentDecorator
  def status
    case req_approval
    when "approval"
      tag.span(req_approval_i18n, style: 'color: #e41414;')
    when "denial"
      tag.span(req_approval_i18n, style: 'color: #0c94f9;')
    else
      tag.span(req_approval_i18n, style: 'color: #a2b9ca;')
    end
  end

  def approval_link(facility)
    case req_approval
    when "request"
      tag.p((link_to "利用者登録は #{req_approval_i18n} です", edit_request_resident_path(id), class: "btn-shine"))
    when "approval"
      tag.p((link_to "利用者登録は #{req_approval_i18n} です", new_request_resident_path(facility_id: facility), class: "btn-shine"))
    else
      tag.p((link_to "ご利用者様の登録申請", new_request_resident_path(facility_id: facility), class: "btn-shine"))
    end
  end
end
