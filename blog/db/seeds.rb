def random_string(min_length, max_length, simple)
  charset = [*('a'..'z'),*('0'..'9'),*('A'..'Z')]
  unless simple
    charset += [*[' ']*10,*['. ']*3]
  end

  return (1 .. rand(min_length..max_length)).map{charset[rand(charset.length)]}.join
end

10.times do |i|
  name = random_string(2, 20, true)
  is_creator = (rand(3) < 2)
  u = User.create(name: name, email: "#{name}@email.com", creator: is_creator)
  
  if is_creator
    # it could be zero times
    1..rand(5).times do |i|
      p = Post.create(user: u, title: "Blog post ##{i}", body: random_string(1, 350, false))
    end
  end
end

users = User.all
Post.all.each do |p|
  # has marks? 66%
  if rand(3) < 2
    users.sample(rand(1..5)).each do |u|
      # don't mark your own posts
      if p.user != u
        Mark.create(post: p, user: u, mark: rand(3..5))
      end
    end
  end

  # has comments? 50%
  if rand(2) == 0
    users.sample(rand(1..3)).each do |u|
      Comment.create(post: p, user: u, body: random_string(1, 120, false))
    end
  end
end
