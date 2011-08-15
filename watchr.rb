#  Uses the watchr gem to monitor for change to any *.rb file in this watchfile's heirarchy, then runs the changed file.
#
# ==== Dependencies
# $ <b><tt>gem install watchr</tt></b>
#
# ==== Examples
# $ <b><tt>watchr your_custom_watchfile.rb</tt></b>

watch('\.rb$') do |matched| 
  sep=10.times do
    print '='
  end
  t=Time.now
  puts "\n"
  puts "#{sep} #{t.to_datetime} #{sep}"
  puts "#{sep} #{matched[0]} #{sep}"
  puts `ruby #{matched[0]}`
end