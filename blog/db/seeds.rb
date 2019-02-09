User.destroy_all

users_hash = 10.times.map do
  email = FFaker::Internet.safe_email
  {
  name: FFaker::Internet.user_name,
  email: email,
  password: email,
  moderator: (rand(3) == 1),
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

comment_hash = 300.times.map do
  commentable = ((rand(2) == 1) ? posts : users).sample
  {
    user: users.sample,
    body: FFaker::Tweet.body,
    commentable_id: commentable.id,
    commentable_type: commentable.class.to_s
  }
end

Comment.create!(comment_hash)
