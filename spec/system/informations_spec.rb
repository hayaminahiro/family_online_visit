require 'rails_helper'

RSpec.describe "Informations", type: :system do
  describe '記事のテスト' do
    let(:facility) { create(:facility) }

    before do
      visit new_facility_session_path
      fill_in 'メールアドレス', with: facility.email
      fill_in 'パスワード', with: facility.password
      click_button 'ログイン'
    end
    describe 'お知らせ機能' do
      context 'お知らせの新規作成' do
        it '作成に成功する' do
          visit new_information_path

          attach_file "information[image]", "#{Rails.root}/public/signup-pic1.jpg"
          fill_in 'information_title', with: '毎年恒例の〇〇イベント'
          fill_in 'information_news', with: '〇〇イベントの説明は〜〜です。'
          find('.info-btn').click
        end
        # it '作成に失敗する' do
        # end
      end

      # context 'お知らせの編集' do
        # it '編集に成功する' do
        # end

        # it '編集に失敗する' do
        # end
      # end
    end
  end
end
