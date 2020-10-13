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

  def modal_title(content)
    content.id.present? ? "入居者情報編集" : "入居者新規登録"
  end

  def component(component_name, locals = {}, &block)
    render("residents/#{component_name}", locals, &block)
  end

  alias :c :component
end
