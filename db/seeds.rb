#Users
User.create!(name: "Boo Mc.Boo",
	         email: "example@test.com",
	         password: "testtest",
	         password_confirmation: "testtest")
#Create 99 users
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@yahoo.com"
  password = "password"
  User.create!(name: name,
              email: email,
              password:              password,
              password_confirmation: password,)
end

#Create invites
users = User.order(:id).take(5)
others = User.where(id: 30..40)
users.each do |user|
  others.each do|other|
    user.invite(other)
  end
end

#Create friends
users = User.order(:id).take(10)
others = User.order(id: :desc).take(10)
users.each do |user|
  others.each do|other|
    user.friend(other)
  end
end


#Create posts
users = User.order(:id).take(10)
5.times do
  content = Faker::Lorem.sentence(3)
  users.each { |user| user.posts.create!(content: content) }
end

#Create comments
posts = Post.order(:id).take(5)
users = User.order(id: :desc).take(5)
posts.each do |post|
  users.each do |user|
    content = Faker::Lorem.sentence(1)
    post.comments.create!(content: content, user_id: user.id)
  end
end

#Create likes
posts = Post.take(5)
users = User.order(id: :desc).take(10)
posts.each do |post|
  users.each do |user|
    post.likes.build(user_id: user.id).save
  end
end
comments = Comment.take(3)
comment_users = users[-5..-1]
comments.each do |comment|
  comment_users.each do |user|
    comment.likes.build(user_id: user.id).save
  end
end