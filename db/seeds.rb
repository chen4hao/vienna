# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 新增管理者及測試者帳號
if User.count < 1 do
  u = User.new
  u.email = "admin@vienna.com.tw"
  u.name = "admin"
  u.title = "管理者"
  u.password = "12345678"              # 最少要八碼
  u.password_confirmation = "12345678" # 最少要八碼
  u.is_admin = true
  u.save

  u2 = User.new
  u2.email = "test@vienna.com.tw"
  u2.name = "test"
  u2.title = "員工"
  u2.password = "123456"              # 最少要八碼
  u2.password_confirmation = "123456" # 最少要八碼
  u2.save

end


