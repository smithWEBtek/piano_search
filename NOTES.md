piano_finder CLI Gem

1. Plan gem and interface

2. Project structure, used "bundle gem piano_finder"

3. Start with entry point - the file run. 

4. Force that to build the CLI interface

5. Stub out the interface

6. Start making things real

7. Discover objects

8. Program


GIT description: 
Version 0.1.0 PianoSearch
Searches Boston Craiglist Musical Instruments for Yamaha P22 or Yamaha U1 pianos for sale. 
Prompts user to choose 'u1' or 'p22'.
Displays prices and headlines of existing posts.
Prompst user to choose a post, to see details.
Displays the Price, Location, Headline and Description (post text) for the chosen post. 


AD#   $PRICE    LOCATION    HEADING
The user can then enter the number corresponding to the ad heading to see the ad details.

pianos_seen   will be an array of the pianos seen
saved_search  saves user choices in a script that can be re-run 
auto_report   re-runs the report at the user's chosen time and emails the summary arrary to the user daily 

CLI workflow:

1. START User types piano_finder
  -puts "Welcome message."
  -puts "This Gem searches your desired state and state_area for Yamaha P22 or Yamaha U1 for sale"
  -puts "Please choose a state, and enter corresponding #: "



2. CHOOSE STATE: CLI shows list of 50 states with AD# == index number to choose, and prompts user for state:

likely using this page as source: 
http://www.craigslist.org/about/sites#US

USER INPUT:______

3. CHOOSE AREA:  input = gets.to_i.strip CLI shows list of areas within chosen state, with (AREA# == index number) to choose and prompts user for state_area:

Example result URL for next scrape (assuming Long Island is chosen:   http://longisland.craigslist.org/ )


OBJECT: ad

An ad has: {
    :brand, 
    :model, 
    :location, 
    :price, 
    :ad_url, 
    :ad_text, 
    :ad_date
    }

4. CHOOSE PIANO MODEL: 
Prompt user for piano model desired
1 = Yamaha U1
2 = Yamaha P22

5. DISPLAY RESULTS
  -Results are returned, sorted by price high to low 
  -CLI shows results as follows: 

AD#   $PRICE    LOCATION    HEADING
1     $1500     Montauk     Used but loved Yamaha P22 for sale...
2     $3500     Long Island Piano Teacher's Pet!, well cared for
3     $800      Melville    Classroom piano, good condition

The user can then enter the number corresponding to the ad heading to see the ad details.

6. CHOOSE AD# to see details
  -user is prompted to enter an AD#

7. DISPLAY DETAILS
  -shows full text of Craigslist ad
  -stores an array for ads seen
  Ex:  pianos_seen = {brand: , model:, price:, location:, ad_url:, reply_to_address: }

8. EMAIL SUMMARY REPORT
  -prompts user: "Would you like a summary report emailed?"
  -y/n
  -if yes, prompt for email address
  -send pianos_seen array to email address entered

9. SAVE SEARCH
  -prompts user to save this search
  -script creates saved search

10. AUTOMATED SEARCH BASED REPORT
  -prompts user: "Would you like to automate this search and receive a daily email summary?"
  -y/n
  -prompts user: "Enter 1 - 24:"
  -prompts user: "Enter AM or PM"
  -gets hour, gets pm
  -script creates s



#############################################
stubbing out my scraper methods: 

#     attr_accessor :brand, :model, :location, :price, :ad_url, :ad_text, :ad_date
#     @@states = []
#     @@areas = []

#   def initialize(user_state, user_area)
#     @user_state = user_state
#     @user_area = user_area
#     scrape_user_state
#     scrape_user_area
#     scrape_mus_instr
#   end

#   def scrape_user_state
#     # scrapes the Craigslist main site for states
#     # pushes them into @@states <<
#   end

#   def scrape_user_area
#     # scrapes the Craigslist main site for states
#     # pushes them into @@areas <<
#   end

#   def scrape_mus_instr
#     # searches musical instruments for terms "Yamaha P22" and "Yamaha U1"
#     # use Nokogiri to get the full HTML of the musical instruments section
#     # find the CSS selectors for ad headers
#     # find the search terms in the as headers
#     # find the search terms in the ad copy
#     # return the results in an array of hashes
#     # self = [{brand:, model:, location:, price:, ad_url:, ad_text:, :ad_date}]xs
#   end

############################################################
############################################################
# making it real: 
  def scrape_posts
    # Nokogiri syntax
    # Craiglist top level url for states and areas
    # syntax to find Musical Instruments
    # syntax to search Musical Instruments for "Yamaha P22" and "Yamaha U1"
    # CSS selectors for :brand, :model, :price, :location, :url, :headline, :text, :date, :id, :reply_email
    # populate self.hash with all of the above items, if available
    # push self.hash into the @@posts array

    post_1 = self.new
    post_1.brand = "Yamaha"
    post_1.model = "P22"
    post_1.price = "$1525"
    post_1.location = "Lower East Side"
    post_1.url = "https://newyork.craigslist.org/mnh/msg/5439936642.html"
    post_1.headline = "Piano - Yamaha 45 Inch - $1525 (Lower East Side)"
    post_1.text = "yadda yadda yadda"
    post_1.date = "2016-02-09 12:54am"
    post_1.id = "5439936642"
    post_1.reply_email = "cltest1@smithwebtek.com"

    @@posts << post_1

    post_2 = self.new
    post_2.brand = "Yamaha"
    post_2.model = "U1"
    post_2.price = "$2700"
    post_2.location = "Syosset"
    post_2.url = "https://longisland.craigslist.org/msg/5469342640.html"
    post_2.headline = "Yamaha U1 Ebony Concert Upright-Perfect - $2700 (syosset)"
    post_2.text = "really goood piano, you ought to buy it"
    post_2.date = "2016-02-28 10:33pm"
    post_2.id = "5469342640"
    post_2.reply_email = "cltest2@smithwebtek.com"

    @@posts << post_2
    @@posts
    # [post_1, post_2]
  end
############################################################
############################################################
require 'open-uri'
require 'Nokogiri'

class PianoSearch::Post
  attr_accessor :price, :location, :headline, :description, :date, :posts, :post_id, :post_ids, :post_url, :post_urls, :post_ary

  def self.scrape_cl
    # price = ""
    # location = ""
    # headline = ""
    # description = ""
    # date = ""
    # @posts = ""
    # @post_id
    # @post_ids = []
    # @post_url = ""
    # @post_urls = []
    # @post_ary = []
    
    doc = Nokogiri::HTML(open("http://boston.craigslist.org/search/msa?query=%22yamaha+u1%22"))
    doc.css("div.content").each do |post|
    @posts = post.css("p.row a")
    end
binding.pry
  end

  def self.scrape_post
# get post_id 
    @posts.each do |item|
    @post_id = item.attributes["href"].value
    @post_ids << @post_id
    end
  end


# # get post_url
#     @post_ids.each do |id|
#     @post_url = "http://boston.craigslist.org#{id}"
#     @post_urls << @post_url
#         end
# # using post_url: 
#     # get price, location, headline, description
#     @post_urls.each do |i|
#         @price = i.css("p.row a span").first.text
#         @location = i.css("span.pnr small").first.text
#         @headline = i.css("span#titletextonly").first.text
#         # @description =
#     end
# binding.pry
# build post_ary

    @post_ary = {
    :headline => @headline,
    :post_id => @post_id,
    :post_url => @post_url,
    :price => @price,
    :location => @location #,
    # :description => @description
    }
binding.pry
  end
    
  def self.post_urls
    @post_urls.uniq.each_with_index do |url, i|
    puts "#{i.to_i+1}. #{url}"
    end
  end

  def self.headings

  end

  def self.post_detail

  end


  # query_url = http://boston.craigslist.org/search/msa?query=%22yamaha+u1%22
  # extract the data-id: 5472276713
  # create post_url: http://boston.craigslist.org/gbs/msd/5472276713.html
  # each area has  3 letter prefix gbs = boston  nos = north shore sob = south of boston

  # http://boston.craigslist.org/gbs/msd/5472276713.html



 
    # doc.css("div.content").first.text

    # doc.css(".colmask h4")[0..50].each do |i|
    #     @@states << i.text
    # end
    # using each state url, find .each of the areas:
    # present list of areas for user to choose from
    # if "h4" include? state[i]
    # #{state} ul li <area>[0..~]
    #PianoSearch::Post.today



    # doc.css(".colmask a").each do |i|
    #     @@area << i.text

    # area: = doc.css(".colmask a")[i].text
    # music_instr_url: =  doc.css("http://#{area}.craigslist.org/search/msa")
    # search = ["yamaha+p22", "yamaha+u1"]

    # query = "#{music_instr_url}?query=#{search_phrase[0]}"
    # # Ex: http://boston.craigslist.org/search/msa?query="yamaha+p22"
    # Ex: http://boston.craigslist.org/search/msa?query=%22yamaha+p22%22

    # Craiglist top level url for states and areas
    # syntax to find Musical Instruments
    # syntax to search Musical Instruments for "Yamaha P22" and "Yamaha U1"
    # CSS selectors for :brand, :model, :price, :location, :url, :headline, :text, :date, :id, :reply_email
    # populate self.hash with all of the above items, if available
    # push self.hash into the @@posts array
    # posts << post
    # posts

    # post_1 = self.new
    # post_1.brand = "Yamaha"
    # post_1.model = "P22"
    # post_1.price = "$1525"
    # post_1.location = "Lower East Side"
    # post_1.url = "https://newyork.craigslist.org/mnh/msg/5439936642.html"
    # post_1.headline = "Piano - Yamaha 45 Inch - $1525 (Lower East Side)"
    # post_1.text = "yadda yadda yadda"
    # post_1.date = "2016-02-09 12:54am"
    # post_1.id = "5439936642"
    # post_1.reply_email = "cltest1@smithwebtek.com"


  def self.reset
    @@posts.clear
  end

end
 
############################################################
############################################################


 
############################################################
############################################################


 
############################################################
############################################################







