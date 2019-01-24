namespace :test do
  desc 'Hello world!'
  task hello_world: :environment do
    puts 'Hello guys!'
  end
end
