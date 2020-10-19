FactoryBot.define do
  factory :user do
    id { 1 }
    name { 'sample' }
    email { 'sample@dic.com' }
    password { 'samplesample' }
    admin { false }
  end
  factory :admin_user, class: User do
    id { 2 }
    name { 'admin2' }
    email { 'admin2@dic.com' }
    password { 'admin2admin2' }
    admin { true }
  end
end
