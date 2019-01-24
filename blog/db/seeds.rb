Comment.destroy_all
Mark.destroy_all
Post.destroy_all
User.destroy_all

users_hash = 10.times.map do {
  name: FFaker::Internet.user_name,
  email: FFaker::Internet.safe_email,
  creator: (rand(3) < 2)
  }
end

users = User.create!(users_hash)

posts_hash = users.select{|user| user.creator}.map do |user|
  rand(5).times.map do {
    user: user,
    title: FFaker::Book.title,
    body: FFaker::Book.description
  }
  end
end

posts = Post.create!(posts_hash.flatten)

mark_hash = posts.select{|post| rand(3)<2}.map do |post|
  users.sample(rand(1..5)).select{|user| post.user != user}.map do |user| {
    post: post,
    user: user,
    mark: rand(3..5)
  }
  end
end

Mark.create!(mark_hash.flatten)

comment_hash = posts.select{|post| rand(2)==0}.map do |post|
  users.sample(rand(1..3)).map do |user| {
    post: post,
    user: user,
    body: FFaker::Tweet.body
  }
  end
end

Comment.create!(comment_hash.flatten)
