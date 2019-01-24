namespace :counter do
  desc 'Count ruby files'
  task ruby_file: :environment do
    # check: find . -name *.rb | wc -l
    puts Dir['**/*'].select{|f| File.extname(f) == '.rb'}.length
  end

  desc 'Count lines in ruby files'
  task ruby_line: :environment do
    # check: find . -name *.rb | xargs cat | wc -l
    cnt = 0
    Dir['**/*'].select{|f| File.extname(f) == '.rb'}
               .each{|fn| f = File.open(fn, "r");
                          f.each{|l| cnt=cnt+1}}
    puts cnt
  end
end
