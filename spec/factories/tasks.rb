FactoryBot.define do
  factory :task do
    # 下記の内容は実際に作成するカラム名に合わせて変更してください
    name { 'test_title' }
    detail { 'test_content' }
    deadline { '2020-10-15' }
    status { 'not_yet' }
    priority { 'low'}
    user
  end

  factory :second_task, class: Task do
    name { 'Factoryで作ったデフォルトのタイトル２' }
    detail { 'Factoryで作ったデフォルトのコンテント２' }
    deadline { '2020-10-16' }
    status { 'in_progress' }
    priority { 'middle'}
    user
  end

  factory :third_task, class: Task do
    name { 'Factoryで作ったデフォルトのタイトル3' }
    detail { 'Factoryで作ったデフォルトのコンテント3' }
    deadline { '2020-10-10' }
    status { 'completed' }
    priority { 'high'}
    user
  end

  factory :test_task, class: Task do
    name { 'ラベルつけたい' }
    detail { 'どうやってラベルつけるの' }
    deadline { '2020-10-10' }
    status { 'completed' }
    priority { 'high'}
    user
    after(:build) do |task|
      # user = create(:user2)
      label = create(:label, name: 'label_test', user_id: 10)
      task.labelings << build(:test_labeling, task_id: task.id, label_id: label.id)
    end
  end
end