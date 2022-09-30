require 'io/console'

filename='timeTable.txt'

def readSubjects
	totalSubjects=[]
	week = %w{Monday Tuesday Wednesday Thursday Friday Saturday Sunday}
	puts " Press enter to skip an entry "
	week.each do |day|
		print "Subject for #{day}: "
		subject=gets.chomp!
		if subject.empty?
			totalSubjects.append("none")
		else
			totalSubjects.append("#{subject}")
		end
	end
	return totalSubjects
end

def keepReadingUntilY?
	while c = STDIN.read_nonblock(1)
	      return true if c == 'y'
	end
	false
end

print "Name: "
name=gets.chomp!
if name.empty?
	puts "Name musn't be empty."
	exit(1)
end

system("clear") || system("cls")

print "Subjects: "
subjectEntries=readSubjects

system("clear") || system("cls")

puts "Time ( use format HH:MM ): "
time=gets.chomp!
if time.empty?
    print "Time cannot be empty."
    exit(1)
end

system("clear") || system("cls")

totalEntries=["#{time}", "#{name}"]
subjectEntries.each do |subject|
    totalEntries.append("#{subject}")
end

totalEntries.each_with_index do |entry, index|
    if entry.length<12
        while entry.length<=12
            totalEntries[index].concat(" ")
        end
    end
    if entry.length>11
        totalEntries[index]=entry[0..11]
    end
end

puts "+--------------------------------------------------------------------------------------------------------------------+"
puts "|TIME        |NAME        |MONDAY      |TUESDAY     |WEDNESDAY   |THURSDAY    |FRIDAY      |SATURDAY    |SUNDAY      |"
puts "+--------------------------------------------------------------------------------------------------------------------+"
puts "|#{totalEntries.join('|')}|"
puts "+--------------------------------------------------------------------------------------------------------------------+"

puts "\nDo you confirm the above entries? ( Press 'y' ): "
confirm=STDIN.getch
if confirm!='y'
	system("clear") || system("cls")
	puts "Okay, Aborting!"
	exit(0)
end

if File.file?("#{filename}")
	File.write("#{filename}", "\n|#{totalEntries.join('|')}|", mode: 'a')
	File.write("#{filename}", "\n+--------------------------------------------------------------------------------------------------------------------+", mode: 'a+')
else
	File.open("#{filename}", mode: 'w')
	File.write("#{filename}", "\n+--------------------------------------------------------------------------------------------------------------------+", mode: 'a')
	File.write("#{filename}", "\n|TIME        |NAME        |MONDAY      |TUESDAY     |WEDNESDAY   |THURSDAY    |FRIDAY      |SATURDAY    |SUNDAY      |", mode: 'a')
	File.write("#{filename}", "\n+--------------------------------------------------------------------------------------------------------------------+", mode: 'a')
	File.write("#{filename}", "\n|#{totalEntries.join('|')}|", mode: 'a')
	File.write("#{filename}", "\n+--------------------------------------------------------------------------------------------------------------------+", mode: 'a+')
end

system("clear") || system("cls")

puts "Success!"
