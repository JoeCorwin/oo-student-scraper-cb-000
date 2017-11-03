require 'pry'
require 'nokogiri'
require 'open-uri'

#
class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    flatiron_students = Nokogiri::HTML(html)

    students = []

    flatiron_students.css("div.student-card").each do |s|
      student_hash = {
        :name => s.css("h4.student-name").text,
        :location => s.css("p.student-location").text,
        :profile_url => s.css("a").attribute("href").value
        }

      students << student_hash
    end

    students
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    sp = Nokogiri::HTML(html)

    profile = {}

    profile_links = sp.css("div.social-icon-container a").map { |link| link.attribute('href').value}
# Scraping social links
    profile_links.each do |link|
      if link.include?('twitter')
        profile[:twitter] = link
      elsif link.include?('linkedin')
        profile[:linkedin] = link
      elsif link.include?('github')
        profile[:github] = link
      else link.include?('http:')
        profile[:blog] = link
      end
    end

# Scraping bio and quote
    profile[:bio] = sp.css("div.bio-content.content-holder p").text
    profile[:profile_quote] = sp.css("div.profile-quote").text

    profile
  end
end



#   # # ///SELECTOR TESTER////
#
#   # def scrape_index_page
#   #   html = File.read("./fixtures/student-site/index.html")
#   #   s = Nokogiri::HTML(html)
#   #   binding.pry
#   # end
#   # scrape_index_page
