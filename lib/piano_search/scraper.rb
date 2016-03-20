class PianoSearch::Scraper
  attr_accessor :search

  def initialize(search)
    @search = search
    get_url_id(search)
  end

  def get_url_id(search)
    @url_id = []
    doc = Nokogiri::HTML(open("http://boston.craigslist.org/search/msa?query=\"#{search}\""))
    doc.css("p.row").each do |row|
    @url_id << row.search("a").attr(name="href").value
    @url_id.delete_if {|i| i.include?("//")}
    end
    self.scrape_url
  end

  def scrape_url
    @url_id.each do |id|
    doc = Nokogiri::HTML(open("http://boston.craigslist.org""#{id}"))
      listing = PianoSearch::PianoListing.new
      listing.price = doc.css("span.price").first.text
      listing.headline = doc.css("span#titletextonly")[0].text
      listing.location = doc.css("small").text.strip.gsub!("(google map)", "")
      listing.detail = doc.css("#postingbody").text
      listing.url = "http://boston.craigslist.org""#{id}"
    end
  end
 
end