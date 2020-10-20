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