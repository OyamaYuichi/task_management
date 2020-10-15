require 'rails_helper'

describe 'タスクモデル機能', type: :model do
  describe '検索機能' do
    # 必要に応じて、テストデータの内容を変更して構わない
    let!(:task) {FactoryBot.create(:task, name: 'sample1')}
    let!(:second_task) {FactoryBot.create(:second_task, name: "sample2")}
    let!(:third_task) {FactoryBot.create(:third_task, name: "sample3")}
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do

        # title_seachはscopeで提示したタイトル検索用メソッドである。メソッド名は任意で構わない。
        expect(Task.get_by_name('sample')).to include(task)
        expect(Task.get_by_name('1')).not_to include(second_task)
        sleep 0.5
        expect(Task.get_by_name('sample1').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        # ここに内容を記載する
        expect(Task.get_by_status('completed')).to include(third_task)
        expect(Task.get_by_status('completed').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスクが絞り込まれる" do
        # ここに内容を記載する
        expect(Task.get_by_name('sample').get_by_status('in_progress')).to include(second_task)
        expect(Task.get_by_name('sample').get_by_status('in_progress')).not_to include(task)
        expect(Task.get_by_name('sample').get_by_status('in_progress').count).to eq 1
      end
    end
  end

  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(name: '', detail: '失敗テスト')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(name: 'test1', detail: '')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(name: 'test1', detail: 'some_text1')
        expect(task).to be_valid
      end
    end
  end
end