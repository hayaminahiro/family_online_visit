require 'rails_helper'

RSpec.describe 'Sessions', type: :system do
  let(:user) { create(:user) }

  it 'ログインページの要素検証' do
    visit new_user_session_path

    expect(page).to have_selector '.new-title', text: 'ログイン'
    expect(page).to have_selector '.field', text:'メールアドレス'
    expect(page).to have_selector '.field', text: 'パスワード'
    expect(page).to have_button 'ログイン'
    expect(page).to have_link '新規アカウント登録'
  end

  describe 'ユーザー認証のテスト' do
    describe 'ユーザー新規登録' do
      before do
        # 新規登録画面へ遷移
        visit step1_signup_index_path
      end
      context '新規登録画面に遷移' do
        it '新規登録に成功する' do
          # step1
          fill_in 'あなたのお名前', with: "test1_user"
          fill_in 'メールアドレス', with: "test1@email.com"
          fill_in 'パスワード', with: "password"
          fill_in 'パスワード再確認', with: "password"
          # 次へボタンをクリック
          find('.button.is-link.is-medium.is-fullwidth.new-btn.has-text-weight-bold').click

          # step2
          fill_in 'zip', with: '1000000'
          sleep 5

          fill_in 'user[prefecture_name]', with: '東京都'
          fill_in 'user[address_city]', with: '千代田区'
          fill_in 'user[address_street]', with: '123456'
          fill_in 'user[phone]', with: '08012345678'
          # 次へボタンをクリック
          find('.button.is-link.is-medium.is-fullwidth.new-btn.has-text-weight-bold').click

          # 確認画面/新規登録ボタンをクリック
          find('input[type="submit"]').click
          expect(page).to have_selector ('.notification')
        end
      end
    end

    # describe 'ユーザーログイン' do
    #   # before do
    #   #   visit new_user_session_path
    #   # end

    #   context 'ログイン画面に遷移' do
    #     it 'ログインに成功する' do
    #       fill_in "メールアドレス", with: user.email
    #       fill_in 'パスワード', with: user.password
    #       click_button 'ログイン'
    #       # expect(page).to have_content 'ログインしました。'
    #       expected to find text 'ログインしました。'
    #     end

    #     it 'ログインに失敗する' do
    #       fill_in 'メールアドレス', with: ''
    #       fill_in 'パスワード', with: ''
    #       click_button 'ログイン'
    #       expect(current_path).to eq new_user_session_path
    #     end
    #   end
    # end
  end
end
