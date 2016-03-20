class PianoSearch::CLI
  attr_accessor :input, :user_query, :user_choice

  def call
    @input = nil
    @user_query = ""
    @user_choice = ""
    menu
  end

  def menu
    puts "Welcome to Boston Craigslist Piano Search - Main Menu"
      until @input == "x"
    puts "🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹"
    puts "Enter 1 for Yamaha U1, 2 for Yamaha P22:"     
      @input = gets.strip.downcase  
    case @input  
      when "1"; @user_query = "%22yamaha+u1%22"; display
      when "2"; @user_query = "%22yamaha+p22%22"; display
      when "x"; goodbye
      when @input.match(/[1,2,x]/) != true; puts "Invalid entry.....please choose again."
      else
      end
    end
  end

  def display
    PianoSearch::Scraper.get_url_id(@user_query)
    PianoSearch::PianoListing.display_headlines
     puts "Please choose a post # to view details:"  
     @input = gets.to_i-1

    PianoSearch::PianoListing.display_user_choice(@input)

    puts "Choose 'post #' to see details, 'menu to return to main menu, 'x' to exit."
    @input = gets.strip.downcase
    if @input == 'menu'; 
      PianoSearch::PianoListing.reset
      menu
    elsif @input == 'x'; goodbye
    elsif @input
    end 
  end

  def goodbye
      puts "🎹 Thank you for using Piano-Search! 🎹"
      Kernel.exit
  end

end