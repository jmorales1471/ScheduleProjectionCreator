require 'rubygems'
require 'nokogiri'
require 'mechanize'
require 'open-uri'
require 'watir'

class Hash
  def lastValue
    values.last
  end
end

  #Get Courses Taken (Saved in semTaken)
  #semTaken = Key -> [[Course,Credit]...TotalCredits]
  def getCoursesTaken
    audit = Nokogiri::HTML(open("JohnAudit.html"))
    coursesTaken = audit.css('tr.takenCourse')
    semTaken = Hash.new{ |h,k| h[k] = []}
    keys = []
    coursesTaken.each  do |node|
      unless node.css('td.grade').text == "EM" || node.css('td.grade').text == "KB"
        key = node.css('td.term').text
        course = node.css('td.course').text.gsub(/\s+/," ")
        credit = node.css('td.credit').text.to_f
        unless key == ""
          keys << key
          semTaken[key] << [course,credit]
        end
      end
    end
    semTaken.each do |k, arr|
      arr.uniq!
      #totalCreditsForSem = arr.reduce(0){|sum, innerArr| sum += innerArr.last}
      #arr << totalCreditsForSem
      semTaken[k] = arr
    end
    File.open("coursesTaken.json", 'w') do |s|
      s.print "coursesTaken = \'{ "
      semTaken.each do|k,vArr|
        s.print "\"" + k + "\":["
        vArr.each do|c|
          textJSON = "{\"courseName\" : \""  + c.first.to_s + "\", \"credits\":\"" + c.last.to_s + "\"}"
          unless c == vArr.last
            textJSON << ","
          end
          s.print textJSON
        end
        unless semTaken[k] == semTaken.lastValue
          s.print "],"
        else
          s.print "]"
        end
      end
      s.print " }\'"
    end
  end


  #Get General Education Courses (Saved in genEdsToTake)
  #semTaken = Key -> [[Course,Credit]]
  def getGEsToTake
    audit = Nokogiri::HTML(open("LuisAudit.html"))
    genEds = audit.css('div.category_GENERAL_EDUC')
    genEdsToTake = []
    genEds.each do |node|
      course = node.css('div.reqTitle').text.gsub(/\d+\.\s+GENED:\s+/,"")
      credit = course[/(\s*\(\d+\s+[A-Z]+\))|(\s-.*)/]
      course.gsub!(/(\s\(.*)|(\s-.*)/,"")
      unless course == "" || course == "COLLEGE SURVEY"
        course.gsub!(/\//," or ")
        if course == "NATURAL SCIENCE"
          nsCourses = node.css('div.subrequirement')
          numToTake = 2 - nsCourses.css('span.Status_NONE').length/2
          numToTake.times { genEdsToTake << [course,5.0] }

        elsif (credit =~ /HOURS/) != nil
          hoursTaken = node.css('tr.takenCourse td.credit')
          totalHours = credit[/\d+/].to_i
          hoursToTake = totalHours - (hoursTaken.reduce(0){|sum,i| sum+=(i.text.to_i)})
          unless hoursToTake == 0
            if hoursToTake % 3 == 0
              numToTake = hoursToTake/3
              numToTake.times { genEdsToTake << [course,3.0] }
            elsif hoursToTake % 5 == 0
              numToTake = hoursToTake/5
              numToTake.times { genEdsToTake << [course,5.0] }
            else
              genEdsToTake << [course,3.0]
            end
          end
        elsif (credit =~ /COURSES?/) != nil
          totalCourses = credit[/\d+/].to_i
          numToTake = totalCourses - node.css('tr.takenCourse').length
          numToTake.times { genEdsToTake << [course,3.0] }
        end
      end
    end
    File.open("genEdsToTake.json", 'w') do |s|
      s.print "genEdsToTake = \'{ \"genEds\":["
      genEdsToTake.each do|vArr|
        textJSON = "{\"courseName\" : \""  + vArr.first.to_s + "\", \"credits\":\"" + vArr.last.to_s + "\"}"
        unless vArr.object_id == genEdsToTake.last.object_id
          textJSON << ","
        end
        s.print textJSON
      end
      s.print "]}\'"
    end
  end

  #Get Core Classes
  def getCoreClasses audit
    fromCourseListNodes = audit.css("td.fromcourselist")
    courseListStr = fromCourseListNodes.to_s
    coreClassesNodes = audit.css("span.draggable")
    coreClassesArr = coreClassesNodes.map do |i|
      arr = []
      arr << i.attribute('department').to_s.gsub(/\s+/,"")
      arr << i.attribute('number').to_s
    end
    puts coreClassesArr.to_s
  end

  #Get Credit Hours for Core Classes
=begin
  browser = Watir::Browser.new
  browser.goto('https://courses.osu.edu/psc/csosuct/EMPLOYEE/PUB/c/COMMUNITY_ACCESS.OSR_CAT_SRCH.GBL?PortalActualURL=https%3a%2f%2fcourses.osu.edu%2fpsc%2fcsosuct%2fEMPLOYEE%2fPUB%2fc%2fCOMMUNITY_ACCESS.OSR_CAT_SRCH.GBL&PortalRegistryName=EMPLOYEE&PortalServletURI=https%3a%2f%2fcourses.osu.edu%2fpsp%2fcsosuct%2f&PortalURI=https%3a%2f%2fcourses.osu.edu%2fpsc%2fcsosuct%2f&PortalHostNode=CAMP&NoCrumbs=yes&PortalKeyStruct=yes')
  browser.input(name: 'OSR_CAT_SRCH_WK_CATALOG_NBR').send_keys('2321')
  browser.input(name: 'OSR_CAT_SRCH_WK_BUTTON1').click
  sleep 5
  catalog = Nokogiri::HTML(open("#{browser.html}"))
=end



=begin
  agent = Mechanize.new
  catPage = agent.get('https://courses.osu.edu/psc/csosuct/EMPLOYEE/PUB/c/COMMUNITY_ACCESS.OSR_CAT_SRCH.GBL?PortalActualURL=https%3a%2f%2fcourses.osu.edu%2fpsc%2fcsosuct%2fEMPLOYEE%2fPUB%2fc%2fCOMMUNITY_ACCESS.OSR_CAT_SRCH.GBL&PortalRegistryName=EMPLOYEE&PortalServletURI=https%3a%2f%2fcourses.osu.edu%2fpsp%2fcsosuct%2f&PortalURI=https%3a%2f%2fcourses.osu.edu%2fpsc%2fcsosuct%2f&PortalHostNode=CAMP&NoCrumbs=yes&PortalKeyStruct=yes')
  form = catPage.forms.first
  form["OSR_CAT_SRCH_WK_CATALOG_NBR"] = '2321'
  catPage = form.submit
  form = catPage.forms.first
  button = form.buttons.first
  form.submit button
  sleep 5
  puts form.fields.to_s
  puts catPage.parser.css('td[colspan="#{5}"]').to_s
=end

getCoursesTaken
getGEsToTake
