#@authors: Sarah Ryherd & Shaina Leibovich
#@date: 9/25/17 Created the file.
#@date: 9/26/17 Added functionality to click different links on osu events pages based on user preference
#@authors: Sarah Ryherd
#@date: 9/28/17 Set up an automated email.
#@authors: John Burgess
#@date: 9/28/17 Printed list of all events titles from INTEREST URL
#@authors: Shaina Leibovich and Aakash Singh
#@date: 10/1/17 added functionality to find category names and map them to a matching URL.
#@authors: Sarah Ryherd, John Burgess, John Morales
#@date: 10/1/17 Retrieved blog post title, URL, and blurb from Buckeyeblogs given a certain category
#@author: John Morales
#@date: 10/1/17 Created HTML message to be sent in email
#@authors: Sarah Ryherd & Shaina Leibovich
#@date: 10/8/17 Allowed user to input multiple categories for digest with error checking. Added option to choose print or email of digest.
#@authors: Aakash Singh
#@date: 10/8/17 Modified terminal output, added dates to email and terminal messages
#@authors: Shaina Leibovich
#@date: 10/8/17 Sorted posts by date
#@authors: Shaina Leibovich
#@date: 10/8/17 Now allows user to pick # of posts, changed some variable names, added comments and error checking for posibility no posts (also handles no categories given)
#@authors: Aakash Singh
#@date: 10/8/17 Added authors to email and terminal messages, error checking of user-input email address, modified error checking of number of posts to display, added documentation
#@authors: Aakash Singh
#@date: 10/8/17 Added styling to email message
#@author: Sarah Ryherd
#@date: 10/8/17 Updated documentation and don't allow input of a category more than once.
#authors: John Morales & John Burgess
#@date: 10/8/17 Made code more modular by introducing methods

require 'rubygems'
require 'mechanize'
require 'nokogiri'
require 'mail'
require 'open-uri'
require 'date'

#@author: Sarah Ryherd & Shaina Leibovich @date: 10/8/17
#asks the user for which categories they would like to see in their event digest
def inputCat allCats, usersCats
  input = " "
  puts "Please enter which categories you would like to see (Press enter after last category):"
  until input.empty?
    input = gets.chomp
    until input.empty? || allCats.key?(input)
      puts "Invalid input. Try again."
      input = gets.chomp
    end
    usersCats << input unless (input.empty? || usersCats.include?(input))
  end
  puts "Collecting blog posts. Please wait."
end

#@author: Everyone @date: 10/1/17
#@edited: John Morales @date: 10/1/17 Debugged code and Learned about Array#uniq! method
#@edited: Aakash Singh @date: 10/8/17 Made error checking of number of displayed posts more Ruby-like
#@edited: Shaina Leibovich @date: 10/8/17 Sorted posts by date, added error checking for no blog posts, allows user to pick number of blog posts
def getAllCatInfo usersCats, allCats
  posts = Array.new
  usersCats.each do |cat|
		 address = "https://undergrad.osu.edu/buckeyes_blog/?cat=" + allCats[cat].to_s

		 agent = Mechanize.new
		 doc = Nokogiri::HTML(open(address))

		 titles = Array.new
		 urls = Array.new
		 blurbs = Array.new
		 authors = Array.new
     dates = Array.new

		 doc.xpath('//h2[@class="grid-tit"]').each do |node|
			 titles.push node.inner_text
			 urls.push node.child.values[0]
		 end
		 doc.xpath('//div[@class="grid-text"]/p').each do |node|
			 blurbs.push node.inner_text
		 end
		 doc.xpath('//p[@class="meta"]/span[@class="author_link"]').each do |node|
  		 	 authors.push node.inner_text
		 end

     doc.xpath('//p[@class="meta"]').each do |node|
       dates.push(Date.parse(node.children[4].to_s.slice(2,12)))
     end

     posts += titles.zip urls, blurbs, dates, authors

  end

  #remove any redundant posts and sort by date (decending)
  posts.uniq!
  posts.sort! {|x, y| y[3] <=> x[3]}

  #make sure that there are blog posts
  unless posts.any?
    puts "No blog posts found. Terminating."
    exit
  end

  #allows user to pick # of posts
  puts "How many blog posts would you like in your digest? Please enter a number between 1 and #{posts.length}"
  n = gets.chomp.to_i
  until (1..posts.length) === n
    puts "Please enter a positive whole number between 1 and #{posts.length}."
    n = gets.chomp.to_i
  end

  emailMsg = '<div style="padding:5px;background-color:#f2f2f2;border-style:solid;border-color:#bb0000">'
  terminalMsg = ''
  posts[0...n].each do |post|
    createMessage(post, emailMsg, terminalMsg)
  end
  emailMsg += '</div>'
  puts terminalMsg

  return emailMsg
end

#@author: John Morales @date: 10/1/17
#@edited: Aakash Singh @date: 10/8/17 Added dates and authors to messages, added styling to email message
#creates the message to be put printed or sent in an email
def createMessage post, emailMsg, terminalMsg
  emailMsg << "<h2><a style=\"color:#bb0000;\" href=\"#{post[1]}\">#{post[0]}</a></h2><span style=\"color:#bb0000;\">Written By: #{post[4]} Date: #{post[3]}</span>\n<p>#{post[2]}</p>\n"
  terminalMsg << "\n#{post[0]}\nWritten by: #{post[4]}\tDate: #{post[3]}\n#{post[2]}\n"
  emailMsg << "<hr><br>"
end

#@author: Sarah Ryherd and Shaina Leibovich @date: 10/8/17
#@edited: Aakash Singh @date: Added error checking of email address input
#function which asks user if they would like an email, then collects their email address
def inputEmail
  puts "Would you like an email containing your event digest? [Y/N]"
  answer = gets.chomp.upcase
  until answer == "Y" || answer == "N"
    puts "Invalid input. Try again."
    answer = gets.chomp.upcase
  end

  case answer
  when "Y"
    puts "Please enter your email address for your event digest: "
    emailAdr = gets.chomp
    until emailAdr =~ /[A-Za-z][\w\.\_\-]*@[A-Za-z]*\.[A-Za-z]+/ do
      print "Invalid email address. Enter again: "
      emailAdr = gets.chomp
    end
    puts "Sending email. Please wait."

  when "N"
    puts "Email won't be sent."
    emailAdr = ""
  end
  return emailAdr
end

#@author: Sarah Ryherd @date: 9/28/17
#uses SMTP and gmail to send an email with the indicated address and message
def sendEmail emailAdr, emailMsg
  options = { :address              => "smtp.gmail.com",
      	     	:port             	  => 587,
      	     	:domain           	  => 'gmail.com',
      	     	:user_name        	  => 'thiccclients@gmail.com',
      	     	:password         	  => 'thethiccerthebetter',
      	     	:authentication   	  => 'plain',
      	     	:enable_starttls_auto => true  }

  Mail.defaults do
    delivery_method :smtp, options
  end

  Mail.deliver do
    to  	    emailAdr
    from	    'thiccclients@gmail.com'
    subject  "Your Blog Posts Digest"

    html_part do
      content_type   'text/html; charset=UTF-8'
      body      	    emailMsg
    end
  end
end

doc = Nokogiri::HTML(open("https://undergrad.osu.edu/buckeyes_blog/"))

#collect all categories from Buckeye Blog
allCats = Hash.new #Set of all categories
doc.xpath('//option[@class="level-0"]').each do |node|
  allCats[node.inner_text] = node.[]("value")
  puts node.inner_text
end

usersCats = Array.new #Array of user's categories
inputCat allCats, usersCats #Fill array of user's categories
emailMsg = getAllCatInfo usersCats, allCats #Collect all data from categories
emailAdr = inputEmail #Get user's email address. Will be "" if no email desired
sendEmail(emailAdr, emailMsg) unless emailAdr == ""
puts "Digest completed. Thank you!"
