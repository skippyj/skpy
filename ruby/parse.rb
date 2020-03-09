# Grab input file for parsing
primary_dict = Hash.new()
sections = []

# Identify section headers
line_num = 0
File.open(ARGV[0]).each_line do |line| 
  if line.match(/sec/) && !line.match(/^[ \t]/)
    mod_line = line.gsub(/, sec\n/, '')
    sections.push(mod_line => line_num)
  end
  line_num += 1
end
sections.count().times do |i|
  line_start = sections[i].values[0]
  line_end = sections.to_a[i+1].nil? ? 0 : sections.to_a[i+1].values[0]
  line_num = 0
  File.open(ARGV[0]).each_line do |line|
    if line_num > line_start && line_num < line_end && !line.match(/sec/) && line.match(/^[ \t]/)
      puts "#{sections[i].keys[0]}: #{line}"
    end
    if line_num > line_start && line_end == 0
      puts "#{sections[i].keys[0]}: #{line}"
    end
    line_num += 1
  end
end


#^[ \t].*(sec)
