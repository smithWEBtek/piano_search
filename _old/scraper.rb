class PianoSearch::Scraper
#do the scraping here!

  def scrape(user_query)
    doc = Nokogiri::HTML(open("http://boston.craigslist.org/search/msa?query=user_query"))
    doc.css("div.content p.row").each do |post_row|

      listing.


    #scrape CL once
    #create new Piano_Listing objects
    #add attributes upon creation

  end


end
