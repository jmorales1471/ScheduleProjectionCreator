require 'rubygems'
require 'nokogiri'
require 'mechanize'
require 'open-uri'

audit = Nokogiri::HTML(open("JohnAudit.html"))

#Get Courses Taken (Saved in semTaken)
#semTaken = Key -> [[Course,Credit]...TotalCredits]
coursesTaken = audit.css('tr.takenCourse')
semTaken = Hash.new{ |h,k| h[k] = []}
coursesTaken.each  do |node|
  unless node.css('td.grade').text == "EM" || node.css('td.grade').text == "KB"
    key = node.css('td.term').text
    course = node.css('td.course').text.gsub(/\s+/," ")
    credit = node.css('td.credit').text.to_f
    unless key == ""
      semTaken[key] << [course,credit]
    end
  end
end
semTaken.each do |k, arr|
  arr.uniq!
  totalCreditsForSem = arr.reduce(0){|sum, innerArr| sum += innerArr.last}
  arr << totalCreditsForSem
  semTaken[k] = arr
end
semTaken.each do |k, arr|
  puts "Key = " + k.to_s + "\t" + arr.to_s
end

#Get General Education Courses (Saved in gEdsToTake)
#semTaken = Key -> [[Course,Credit]]
puts ""
genEds = audit.css('div.category_GENERAL_EDUC')
gEdsToTake = []
genEds.each do |node|
  course = node.css('div.reqTitle').text.gsub(/\d+\.\s+GENED:\s+/,"")
  credit = course[/(\s*\(\d+\s+[A-Z]+\))|(\s-.*)/]
  course.gsub!(/(\s\(.*)|(\s-.*)/,"")
  unless course == "" || course == "COLLEGE SURVEY"
    if course == "NATURAL SCIENCE"
      nsCourses = node.css('div.subrequirement')
      numToTake = 2 - nsCourses.css('span.Status_NONE').length/2
      numToTake.times { gEdsToTake << [course,5.0] }
    elsif (credit =~ /HOURS/) != nil
      hoursTaken = node.css('tr.takenCourse td.credit')
      totalHours = credit[/\d+/].to_i
      hoursToTake = totalHours - (hoursTaken.reduce(0){|sum,i| sum+=(i.text.to_i)})
      unless hoursToTake == 0
        if hoursToTake % 3 == 0
          numToTake = hoursToTake/3
          numToTake.times { gEdsToTake << [course,3.0] }
        elsif hoursToTake % 5 == 0
          numToTake = hoursToTake/5
          numToTake.times { gEdsToTake << [course,5.0] }
        else
          gEdsToTake << [course,3.0]
        end
      end
    elsif (credit =~ /COURSES?/) != nil
      totalCourses = credit[/\d+/].to_i
      numToTake = totalCourses - node.css('tr.takenCourse').length
      numToTake.times { gEdsToTake << [course,3.0] }
    end
  end
end
puts gEdsToTake.length
gEdsToTake.each {|i| puts i.to_s}

#Get Credit Hours for Core Classes
mechanize = Mechanize.new
catPage = mechanize.get('https://courses.osu.edu/psp/csosuct/EMPLOYEE/PUB/c/COMMUNITY_ACCESS.OSR_CAT_SRCH.GBL')
puts catPage.forms.to_s
