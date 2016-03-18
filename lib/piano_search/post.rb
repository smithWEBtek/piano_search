require 'open-uri'
require 'Nokogiri'

PianoSearch::Post .scrape_clu1
PianoSearch::Post.scrape_clp22

Scraper.scrape_common_pianos


posts = [] 
posts << clu1_scrape.scrape_posts
posts << scrape_clp22.scrape_posts

PianoListing.all #=> [#<Piano>, #<Piano>]

class PianoListing
  attr_accessor :price, :location, :url, :description
  # What does PianoListing have now?
  # 8, price, price=
  @@all = []

  def self.all
    @@all
  end

  def similar_priced_pianos
    @@all.select{|p| p.price.between?(self.price-100, self.price+100)}
  end

  def intialize
    @@all << self # a particular piano
  end
end

class Scraper
  STATES = {
    "New York" => "newyork",
    "Boston" => "boston",
    "San Franscico" => "sanfranscico"
  }

  def Scraper.scrape_common_pianos
    clu1_scrape = PianoSearch::Scraper.new("yamaha u1", "New York")
    scrape_clp22 = PianoSearch::Scraper.new("yamaha p22", "Boston")
    scrape_u3 = PianoSearch::Scraper.new("yamaha u3", "Chicago")
  end

  def initialize(query, state)
    @query = query
    @state  = state
  end

  def scrape_posts
    doc = Nokogiri::HTML(open("http://#{STATES[@state]}.craigslist.org/search/msa?query=#{@query}"))
    doc.css("div.content p.row").each do |post_row|
      <div class="row">
        <a href="url"></a>
        <span class="price">
        <p clas="Description">
        <span class="location"
      </div>

      piano_listing = PianoListing.new
      piano_listing.url = post_row.css("a").attr("href").text
      piano_listing.name = post_row.css("a").text
      piano_listing.price = post_row.css("span.price").text

    end
  end
end


# How many posts should I have? 

class PianoSearch::Post 

  # Scraping Data - Scraper
  # Displaying data in the CLI - CLI
  # Storing about Posts - PianoListing


  @@states_areas_urls = {}

  # def self.scrape_states_areas_urls
  #   doc = Nokogiri::HTML(open("https://www.craigslist.org/about/sites"))
  #   doc.css("div.content").each do |state|
  # binding.pry
  #     @@states_areas_urls
  #   end
  # end

  def self.scrape_clu1
    doc = Nokogiri::HTML(open("http://boston.craigslist.org/search/msa?query=%22yamaha+u1%22"))
    doc.css("div.content").each do |post|
    @posts = post.css("p.row a")
    end
    self.scrape_posts
  end

    def self.scrape_clp22
    doc = Nokogiri::HTML(open("http://boston.craigslist.org/search/msa?query=%22yamaha+p22%22"))
    doc.css("div.content").each do |post|
    @posts = post.css("p.row a")
    end
    self.scrape_posts
  end

  def self.scrape_posts
    @post_id = "" # Class Instance Variables
    @post_ids = []
    @posts.each do |item|
    @post_id = item.attributes["href"].value
    @post_ids << item.attributes["href"].value
    @post_ids.delete_if { |item| item.include?("//") }
    @post_ids = @post_ids.uniq
    end
    self.create_urls
  end
    
  def self.create_urls
    @post_url = ""
    @post_urls = []
    @post_ids.uniq.each do |id|
    @post_urls << "http://boston.craigslist.org#{id}"
    end
  end

  def self.show_headings
    @post_ary = []
    @post_hash = {}
    @post_urls.each_with_index do |url,i|
    doc = Nokogiri::HTML(open("#{url}"))
    @post_hash = {
        :price => doc.css("span.price").text,
        :location => doc.css("small").text.gsub!("\n(google map)\n",""),
        :headline => doc.css("span#titletextonly").text,
        :description => doc.css("#postingbody").text
    }
    puts "#{i+1}  #{@post_hash[:price]}  #{@post_hash[:headline]} "
    puts "----------------------------------------------"
     end
  end

  def self.scrape_detail
    doc = ""
    @post_ary = []
    @post_hash = {}
    @post_urls.each do |url|
    doc = Nokogiri::HTML(open("#{url}"))
    @post_hash = {
        :price => doc.css("span.price").text,
        :location => doc.css("small").text.gsub!("\n(google map)\n",""),
        :headline => doc.css("span#titletextonly").text,
        :description => doc.css("#postingbody").text
    }
    @post_ary << @post_hash
     end
  end

  def self.show_detail(input)
    post = @post_ary[input]
    puts "#{post[:price]}  #{post[:headline]}  #{post[:location]}"
    puts post[:description]
  end

end
