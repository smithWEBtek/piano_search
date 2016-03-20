class PianoSearch::Scraper

  def self.scrape_cl(search_phrase)

    url = "http://boston.craigslist.org/search/msa?query=#{search_phrase}"
    # binding.pry  
    doc = Nokogiri::HTML(open(url))

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
