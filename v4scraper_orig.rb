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