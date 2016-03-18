class PianoSearch::CLI
  attr_accessor :user_query, :input

  def call
    start
  end

  def start
    input = nil
    user_query = ""
    puts ""
    puts "🎹  Welcome to Boston Craigslist Piano Search 🎹"
    until input == "x"
      puts "Please enter 1 for Yamaha U1, or enter 2 for Yamaha P22:"     
        input = gets.strip.downcase
          
          if input == "1"; user_query = "%22yamaha+u1%22"
            puts "Here are current Yamaha U1 pianos for sale: "
            PianoSearch::Scraper.get_url_id(user_query)
            PianoSearch::PianoListing.display
          
          elsif input == "2"; user_query = "%22yamaha+p22%22"
            puts "Here are current Yamaha P22 pianos for sale: "
            PianoSearch::Scraper.get_url_id(user_query)
            PianoSearch::PianoListing.display
          
          elsif input == "x"
            goodbye
          else  
        end
      end
  end

  def goodbye
      puts "🎹 Thank you for using Piano-Search! 🎹"
      Kernel.exit
  end

end