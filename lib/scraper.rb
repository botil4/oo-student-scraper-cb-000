require 'open-uri'
require 'Nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    name = doc.css(".student-card").text
    binding.pry
  end

  def self.scrape_profile_page(profile_url)

  end

end
