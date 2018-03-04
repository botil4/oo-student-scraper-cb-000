require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = doc.css(".student-card")
    students.collect do |student|
      {
     :name => student.css(".card-text-container .student-name").text,
     :location => student.css(".card-text-container .student-location").text,
     :profile_url => student.css("a").attribute("href").value
   }
   end
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    student = {twitter: "", linkedin: "", github: "", blog: "", profile_quote: "", bio: ""}
    social = doc.css("div.social-icon-container a")
    stats = social.each do |social|
      url = social.attribute("href").text
      case url
      when /.*twitter.*/
        student[:twitter] = url
      when /.*linkedin.*/
        student[:linkedin] = url
      when /.*github.*/
        student[:github] = url
      else
        student[:blog] = url
      end
    end

    student[:profile_quote] = doc.css("div.profile-quote").text
    student[:bio] = doc.css("div.description-holder p").text
    student.delete_if{|k,v| v == ""}
    student
  end

end
