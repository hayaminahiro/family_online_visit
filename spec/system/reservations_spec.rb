require 'rails_helper'

RSpec.describe 'Reservations', type: :system do
  before do
    @facility = create(:facility)
    @user = create(:user)
    visit new_facility_session_path
    fill_in 'メールアドレス', with: @facility.email
    fill_in 'パスワード', with: @facility.password
    click_button 'ログイン'
  end

  it '予約の新規作成画面の要素検証' do
    # 新規予約画面を開く
    visit new_facility_reservation_path(@facility, date: Time.zone.today, time: Time.current, user: @user)
    # 各要素が正しく表示されていること
    expect(page).to have_selector 'h1', text: '予約情報確認'
    expect(page).to have_selector 'th', text: 'ご家族名前'
    expect(page).to have_selector 'th', text: 'メールアドレス'
    expect(page).to have_selector 'th', text: '面会したい利用者'
    expect(page).to have_selector 'th', text: '予約日'
    expect(page).to have_selector 'th', text: '予約時間'
    expect(page).to have_button '予約を決定する'
    expect(page).to have_link '予約ページ戻る'
  end

  describe '予約機能のテスト' do
    context '面会希望利用者は未入力' do
      it '予約の新規作成の成功' do
        skip '面会利用者の取得できない為保留'
      end
      it '予約の新規作成の失敗検証(面会希望利用者未入力)' do
        visit new_facility_reservation_path(@facility, date: Time.zone.today, time: Time.current, user: @user)
        fill_in 'reservation_comment', with: "コメント記入"
        click_on '予約を決定する'
        # エラーメッセージを画面に出力
        expect(page).to have_selector 'li', text: '面会希望利用者を入力してください'
      end
    end
  end

  describe '予約関連画面遷移のテスト' do
    context '予約indexページから検証始める' do
      it '予約indexページの要素検証' do
        visit facility_reservations_path(@facility, user: @user)
        expect(page).to have_selector 'h1', text: '予約日時選択'
        expect(page).to have_selector 'h1', text: '予約情報一覧'
        expect(page).to have_link '週間カレンダー'
      end

      it '月間/週間カレンダーの切り替え/過去の予約/戻るボタン検証' do
        visit facility_reservations_path(@facility, user: @user)
        click_link '週間カレンダー'
        expect(page).to have_link '月間カレンダー'
        click_link '月間カレンダー'
        expect(page).to have_link '週間カレンダー'
        click_link '戻る'
        expect(page).to have_selector 'h1', text: 'ご家族一覧'
      end
    end

    context '予約新規作成ページから検証始める' do
      it '予約ページ戻るボタンの検証' do
        visit new_facility_reservation_path(@facility, date: Time.zone.today, time: Time.current, user: @user)
        click_link '予約ページ戻る'
        expect(page).to have_selector 'h1', text: "予約日時選択"
        expect(page).to have_selector 'h1', text: '予約情報一覧'
        expect(page).to have_link '週間カレンダー'
        click_link '過去の予約'
        expect(page).to have_selector 'h1', text: '過去の予約一覧'
      end
    end
  end
end
