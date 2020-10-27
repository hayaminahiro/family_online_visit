module ResidentsHelper
  def modal_title(content)
    content.id.present? ? "入居者情報編集" : "入居者新規登録"
  end

  def component(component_name, locals = {}, &block)
    render("residents/#{component_name}", locals, &block)
  end

  alias :c :component
end
