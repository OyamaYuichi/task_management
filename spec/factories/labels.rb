FactoryBot.define do
  factory :label do
    association :user
    name { 'A' }
    user_id { 1 }
  end

  factory :second_label, class: Label do
    name { 'B' }
    user_id { 2 }
  end
end
