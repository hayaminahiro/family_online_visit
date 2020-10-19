module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
		@devise_mapping ||= Devise.mappings[:user]
  end

  def grouped_facility(information)
    information.group_by(&:facility_id)
  end
end
