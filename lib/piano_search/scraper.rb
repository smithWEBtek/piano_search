class PianoSearch::Scraper
  attr_accessor :user_query, :url_id, :url, :price, :headline, :location, :description
  
  def self.get_url_id(user_query)
    puts "hey....the PianoSearch::Scraper.get_url_id method started....."
    @url_id = []
    doc = Nokogiri::HTML(open("http://boston.craigslist.org/search/msa?query=\"#{user_query}\""))
    doc.css("p.row").each do |post|
    @url_id << post.search("a").attr(name="href").value
    @url_id.delete_if {|i| i.include?("//")}
    end
    self.scrape_url_id
  end

  def self.scrape_url_id
    puts "hey....the PianoSearch::Scraper.scrape_url_id method started....."
    @url_id.each do |id|
    doc = Nokogiri::HTML(open("http://boston.craigslist.org""#{id}"))
      puts "------------------------------------------------------"
      puts piano_listing = PianoSearch::PianoListing.new
      puts piano_listing.price = doc.css("span.price").first.text
      puts piano_listing.headline = doc.css("span#titletextonly")[0].text
      puts piano_listing.location = doc.css("small").text.strip
      # puts piano_listing.description = doc.css("#postingbody").text
      # puts piano_listing.url = "http://boston.craigslist.org""#{id}"
      puts "------------------------------------------------------"
    end
  end
 
end
