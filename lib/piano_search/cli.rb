class PianoSearch::CLI
  attr_accessor :search_choice, :post_choice

  def call
    menu
  end

  def menu
    PianoSearch::PianoListing.reset
    @input = nil
    until @input == "x"
    puts "🎹 Boston Craigslist Piano Search 🎹"
    puts "Enter   [1]=Yamaha U1    [2]=Yamaha P22    [x]=exit"     
      @search_choice = gets.to_s.strip.downcase  
    case @search_choice
      when "1"
        @search_choice = "%22yamaha+u1%22"
        display
      when "2"
        @search_choice = "%22yamaha+p22%22"
        display
      when @search_choice == "x";
        goodbye
      else 
        puts ""
        puts "INVALID ENTRY: Please choose 1, 2 or X"
        puts ""
      end
    end
  end

  def display
    PianoSearch::PianoListing.reset
    scrape = PianoSearch::Scraper.new(@search_choice)
    PianoSearch::PianoListing.headlines

    until valid?(@post_choice)
      puts "Enter post [#] for details"   
        @post_choice = gets.to_i
      case @post_choice
        when @post_choice.valid?;
          PianoSearch::PianoListing.detail(@post_choice)
          display
        else   
        end
      end
    end

  def valid?(choice)
    choice.between?(0,PianoSearch::PianoListing.all.size)
  end

  def goodbye
      puts "🎹 Thank you for using Piano-Search! 🎹"
      Kernel.exit
  end

end