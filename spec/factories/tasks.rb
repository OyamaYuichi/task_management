FactoryBot.define do
  factory :task do
    # 下記の内容は実際に作成するカラム名に合わせて変更してください
    name { 'test_title' }
    detail { 'test_content' }
    deadline { '2020-10-15' }
    status { 'not_yet' }
    priority { 'low'}
    user_id { 1 }
  end

  factory :second_task, class: Task do
    name { 'Factoryで作ったデフォルトのタイトル２' }
    detail { 'Factoryで作ったデフォルトのコンテント２' }
    deadline { '2020-10-16' }
    status { 'in_progress' }
    priority { 'middle'}
    user_id { 2 }
  end

  factory :third_task, class: Task do
    name { 'Factoryで作ったデフォルトのタイトル3' }
    detail { 'Factoryで作ったデフォルトのコンテント3' }
    deadline { '2020-10-10' }
    status { 'completed' }
    priority { 'high'}
    user_id { 3 }
  end
end