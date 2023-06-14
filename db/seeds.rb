# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
p '==================== admin create ===================='
Admin.create!(email: "admin@example.com", password: "password")

Sentiment.create([
  { name: '満足' },
  { name: '感謝' },
  { name: '嬉しい' },
  { name: 'ワクワク' },
  { name: '関心' },
  { name: 'ドキドキ' },
  { name: '安心' },
  { name: '穏やか' },
  { name: '普通' },
  { name: '退屈' },
  { name: 'モヤモヤ' },
  { name: '緊張' },
  { name: '不安' },
  { name: '悲しい' },
  { name: '疲れた' },
  { name: '後悔' },
  { name: '恐れる' },
  { name: 'イライラ' },
  { name: '怒り' },
  { name: '嫌い' }
])