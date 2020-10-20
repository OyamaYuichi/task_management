# User.create!(
#   name: 'admin',
#   email: 'admin@dic.com',
#   admin: true,
#   password: 'adminadmin',
#   password_confirmation: 'adminadmin',
# )

User.find_or_create_by!(email: 'admin@dic.com') do |user|
  user.name = 'admin'
  user.admin = true
  user.password = 'adminadmin'
  user.password_confirmation = 'adminadmin'
end

10.times do |i|
  User.create!(
    name: "user#{i + 1}",
    email: "user#{i + 1}@dic.com",
    admin: false,
    password: "user#{i + 1}user#{i + 1}",
    password_confirmation: "user#{i + 1}user#{i + 1}",
  )
end

100.times do |i|
  Task.create!(
    name: "task#{i + 1}",
    detail: "task detail#{i + 1}",
    deadline: Faker::Date.between(from: '2019-09-23', to: '2023-09-25'),
    status: rand(3),
    priority: rand(3),
    user_id: rand(1..10)
  )
end

5.times do |n|
  Label.create!(
    name: Faker::Lorem.word,
    user_id: rand(1..10)
  )
end

10.times do |i|
  Labeling.create!(
    task_id: rand(1..100),
    label_id: rand(1..5)
  )
end