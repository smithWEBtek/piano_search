class PianoSearch::Scraper

  def self.scrape_cl(search_phrase)
    # doc = Nokogiri::HTML(open("http://boston.craigslist.org/search/msa?query=\"#{user_query}\""))
    # doc = Nokogiri::HTML(open("http://boston.craigslist.org/search/msa?query=\"#{user_query}\""))
  
    # url = "http://boston.craigslist.org/search/msa?query=#{search_phrase}"
    # binding.pry  
    # doc = Nokogiri::HTML(open(url))

    doc = Nokogiri::HTML(open("http://boston.craigslist.org/search/msa?query=#{search_phrase}"))
    # doc = Nokogiri::HTML(open("http://boston.craigslist.org/search/msa?query=\"#{search_phrase}\""))
  

    doc.css("p.row").each do |i|
      listing = PianoSearch::PianoListing.new
      listing.price = i.css("span.price").first.text
      listing.headline = i.css("span#titletextonly")[0].text
      listing.location = i.css(".pnr small").first.text.strip.gsub("(","").gsub(")","")
      listing.url = "http://boston.craigslist.org#{i.css("a.hdrlnk").attr("href").value}"
      doc = Nokogiri::HTML(open("#{listing.url}"))
      listing.description = doc.css("#postingbody").text
    end
  end
 
end


# http://boston.craigslist.org/search/msa?query=%22yamaha+u1%22

# http://boston.craigslist.org/search/msa?query=%22yamaha+p22%22

# http://boston.craigslist.org/search/msa?query=kawai

# http://boston.craigslist.org/search/msa?query=kawai
# class PianoSearch::Scraper

#   def self.get_url_id(user_query)
#     @url_id = []
#     doc = Nokogiri::HTML(open("http://boston.craigslist.org/search/msa?query=\"#{user_query}\""))
#     doc.css("p.row").each do |post|
#     @url_id << post.search("a").attr(name="href").value
#     @url_id.delete_if {|i| i.include?("//")}
#     end
#     self.scrape_url_id
#   end

#   def self.scrape_url_id
#     @url_id.each do |id|
#     doc = Nokogiri::HTML(open("http://boston.craigslist.org""#{id}"))
#       post = PianoSearch::PianoListing.new
#       post.price = doc.css("span.price").first.text
#       post.headline = doc.css("span#titletextonly")[0].text
#       post.location = doc.css("small").text.strip.gsub!("(google map)", "")
#       post.description = doc.css("#postingbody").text
#       post.url = "http://boston.craigslist.org""#{id}"
#     end
#   end
 
# end
