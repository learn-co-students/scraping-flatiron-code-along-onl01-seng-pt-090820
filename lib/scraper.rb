require 'nokogiri'
require 'open-uri'

require_relative './course.rb'

class Scraper
  
  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end
  
  def get_page 
    doc = Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
  end    
    
  def get_courses
    courses = self.get_page.css(".post")
  end
    
  def make_courses  
    #doc.css(".post").first.css("h2").text
    #doc.css(".post").fist.css(".date").text
    #doc.css("post").first.css("p").text
    self.get_courses.each {|page|
      course = Course.new 
      course.title = page.css("h2").text
      course.schedule = page.css(".date").text 
      course.description = page.css("p").text
    }
    
  end  
end

Scraper.new.print_courses

