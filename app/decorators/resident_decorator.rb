# frozen_string_literal: true

module ResidentDecorator
  def modal_title(content)
    content.id.present? ? "入居者情報編集" : "入居者新規登録"
  end
end
