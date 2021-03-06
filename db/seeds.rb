# ユーザー
User.create!(name:  "Example User",
  email: "example@railstutorial.org",
  password:              "foobar",
  password_confirmation: "foobar",
  admin:     true,
  activated: true,
  activated_at: Time.zone.now,
  primary_name: "Example_User")

3.times do |n|
  name  = "TestUser_#{n + 1}"
  email = "test-#{n + 1}@railstutorial.org"
  password = "password"
  primary_name = "test_#{n + 1}"
  User.create!(name:  name,
      email: email,
      password:              password,
      password_confirmation: password,
      activated: true,
      activated_at: Time.zone.now,
      primary_name: primary_name)
  end

99.times do |n|
name  = Faker::Name.name
email = "example-#{n+1}@railstutorial.org"
password = "password"
primary_name = "#{n}user"
User.create!(name:  name,
    email: email,
    password:              password,
    password_confirmation: password,
    activated: true,
    activated_at: Time.zone.now,
    primary_name: primary_name)
end

# マイクロポスト
users = User.order(:created_at).take(6)
50.times do
content = Faker::Lorem.sentence(5)
users.each { |user| user.microposts.create!(content: content) }
end

# リプライポスト
user = User.second
user.microposts.create!(content: "single reply test, @Example_User !!!")
user.microposts.create!(content: "multi reply test, @test_2 , @test_3 and @Example_User !!!")

# リレーションシップ
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }