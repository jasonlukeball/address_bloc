def greeting
  greeting = ARGV[0]
  ARGV[1..ARGV.length].each {|n| puts "#{greeting} #{n}"}
end

greeting
