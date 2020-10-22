require 'rails_helper'
RSpec.describe 'ユーザ登録・ログイン・ログアウト機能', type: :system do

  def user_login
    visit new_session_path
    fill_in 'session[email]', with: 'sample@dic.com'
    fill_in 'session[password]', with: 'samplesample'
    click_button 'ログイン'
  end

  def admin_user_login
    visit new_session_path
    fill_in 'session[email]', with: 'admin2@dic.com'
    fill_in 'session[password]', with: 'admin2admin2'
    click_button 'ログイン'
  end

  describe 'ユーザ登録のテスト' do
    context 'ユーザのデータがなくログインしていない状態' do
      it 'ユーザ新規登録のテスト' do
        visit new_user_path
        fill_in "名前",	with: "user1"
        fill_in "メールアドレス",	with: "user1@dic.com"
        fill_in "パスワード",	with: "user1user1"
        fill_in "確認用パスワード",	with: "user1user1"
        click_button '新規登録'
        expect(page).to have_content 'user1'
        expect(page).to have_content 'user1@dic.com'
      end

      it 'ユーザがログインせずタスク一覧画面に飛ぼうとしたとき、ログイン画面に遷移' do
        # visit new_user_path
        # binding.pry
        # click_link 'TOP'
        visit tasks_path
        expect(page).to have_content 'ログインしてください'
        expect(current_path).to eq new_session_path
      end
    end
  end

  describe 'セッション機能のテスト' do
    before do
      @user = FactoryBot.create(:user)
      FactoryBot.create(:admin_user)
      user_login
    end

    context 'ログインしていない状態でユーザーのデータがある場合' do
      it 'ログインができること' do
        expect(current_path).to eq user_path(@user.id)
      end
    end

    context '一般ユーザでログインしている状態' do
      it '自分の詳細画面（マイページ）に飛べること' do
        visit tasks_path
        # binding.pry
        click_link @user.name

        expect(current_path).to eq user_path(1)
      end

      it '一般ユーザが他人の詳細画面に飛ぶとタスク一覧ページに遷移すること' do
        visit user_path(2)
        expect(current_path).to eq tasks_path
      end

      it 'ログアウトができること' do
        click_link 'ログアウト'
        expect(page).to have_content 'ログアウトしました'
        expect(current_path).to eq new_session_path
      end
    end
  end

  describe '管理画面のテスト' do
    before do
      @user = FactoryBot.create(:user)
      @admin_user = FactoryBot.create(:admin_user)
    end

    context '一般ユーザーでログインしている状態' do
      it '一般ユーザは管理画面にアクセスできないこと' do
        user_login
        visit admin_users_path
        expect(current_path).to eq root_path
      end
    end

    context '管理者でログインしている状態' do
      before do
        admin_user_login
        click_link 'ユーザー'
      end

      it '管理ユーザは管理画面にアクセスできること' do
        expect(page).to have_content '「ユーザー」一覧'
        expect(current_path).to eq admin_users_path
      end

      it '管理ユーザはユーザの新規登録ができること' do
        click_link '新規ユーザー登録'
        fill_in '名前', with: 'user1'
        fill_in 'メールアドレス', with: 'user1@dic.com'
        fill_in 'パスワード', with: 'user1user1'
        fill_in 'パスワード確認', with: 'user1user1'
        click_on '登録'

        expect(page).to have_content 'を登録しました'
      end

      it '管理ユーザはユーザの詳細画面にアクセスできること' do
        click_link 'sample'
        expect(current_path).to eq admin_user_path(1)
        expect(page).to have_content 'sampleさんの登録情報'
      end

      it '管理ユーザはユーザの編集画面からユーザを編集できること' do
        edit_btns = all('.edit')
        edit_btns[0].click
        fill_in '名前', with: 'samplesample'
        fill_in 'パスワード', with: 'samplesample'
        fill_in 'パスワード確認', with: 'samplesample'

        click_button '登録'

        expect(page).to have_content 'samplesample'
      end

      it '管理ユーザはユーザの削除をできること' do
        destroy_btns = all('.destroy')
        destroy_btns[0].click

        page.driver.browser.switch_to.alert.accept

        expect(page).to have_content 'アカウントを削除しました'
      end

    end
  end
end