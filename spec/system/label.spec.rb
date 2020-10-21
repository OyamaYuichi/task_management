require 'rails_helper'

RSpec.describe 'ラベル機能', type: :system, js: true do
  before do
    @user = User.create(name: 'user', email: 'user@sample.com', password:'useruser')
    @task = FactoryBot.create(:task, name: 'task', deadline: DateTime.now, status: 'in_progress', priority: 'high', user_id: @user.id)
    visit root_path
    # binding.pry
    click_on 'ログイン'
    fill_in 'session[email]', with: 'user@sample.com'
    fill_in 'session[password]', with: "useruser"
    click_on 'ログイン'
  end

  describe 'ラベル機能' do
    context '新規ユーザーが新規にタスクを登録する場合' do
      it '既存ラベルは存在しない' do
        visit new_task_path
        label_list = all('.form-label')
        expect(label_list.count).to eq 0
      end
    end

    context '新規にラベルを作成する場合' do
      it 'タスク一覧から新規ラベル作成ページに遷移できる' do
        visit tasks_path
        click_on '新規ラベル作成'
        expect(page).to have_current_path(new_label_path)
      end

      it 'ユーザー詳細ページから新規ラベル作成ページに遷移できる' do
        visit user_path(@user.id)
        click_on '新規ラベル作成'
        expect(page).to have_current_path(new_label_path)
      end

      it 'ラベルを作成でき、タスク作成画面に表示される' do
        visit tasks_path
        click_on '新規ラベル作成'
        fill_in 'ラベル名', with: "ラベル１"
        click_on '登録'
        expect(page).to have_content '新しいラベルを作成しました'
        # expect(page).to have_current_path user_path(@user.id)
        # binding.pry
        new_create = all('.new-create')
        new_create[0].click
        # label_list = all('#task_label_ids')
        expect(page).to have_content 'ラベル１'
      end
    end
  end

end