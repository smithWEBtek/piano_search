require 'open-uri'
require 'Nokogiri'

class PianoSearch::Post  

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
    @post_id = ""
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
    doc = ""
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
