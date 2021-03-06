# frozen_string_literal: true

module RequestResidentDecorator
  def status
    case req_approval
    when "approval"
      tag.span(req_approval_i18n, style: 'color: rgb(2,148,126);')
    when "denial"
      tag.span(req_approval_i18n, style: 'color: rgb(204,13,53);')
    else
      tag.span(req_approval_i18n, style: 'color: rgb(162,184,202)')
    end
  end

  def approval_link(facility)
    default_request_link = tag.p((link_to "ご利用者様の登録申請", new_request_resident_path(facility_id: facility), class: "btn-shine"))

    case req_approval
    when "request"
      tag.p((link_to "利用者登録は #{req_approval_i18n} です", edit_request_resident_path(id), class: "btn-shine"))
    when "approval"
      return default_request_link unless current_user.resident_ids.any? { |id| facility.resident_ids.include?(id) }

      tag.p((link_to "利用者登録は #{req_approval_i18n} です", new_request_resident_path(facility_id: facility), class: "btn-shine"))
    else
      default_request_link
    end
  end

  def approval_link_request(facility)
    case req_approval
    when "request"
      tag.p((link_to "利用者登録は #{req_approval_i18n} です", edit_request_resident_path(id), class: "link-design"))
    when "approval"
      tag.p((link_to "利用者登録は #{req_approval_i18n} です", new_request_resident_path(facility_id: facility), class: "link-design"))
    else
      tag.p((link_to "ご利用者様の登録申請", new_request_resident_path(facility_id: facility), class: "link-design"))
    end
  end

  def exclude_ids
    Resident.all.where.not(facility_id: current_facility.id)
  end
end
