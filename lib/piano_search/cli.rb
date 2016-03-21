class PianoSearch::CLI
  attr_accessor :input, :search_choice, :post_choice, :int

  def call
    menu
  end

  def menu
    PianoSearch::PianoListing.reset
    @search_choice = nil
    until @search_choice == "x"
    puts "🎹 MENU: Boston Craigslist Piano Search 🎹"
    puts "Enter: [1]=Yamaha U1    [2]=Yamaha P22    [x]=exit"     
      @input = gets.to_s.strip.downcase
      if @input == "1"; @search_choice = "%22yamaha+u1%22"; 
        data
      elsif @input == "2"; @search_choice = "%22yamaha+p22%22"; 
        data
      elsif @input == "x";
        exit
      else 
      end
    end
  end

  def invalid
    puts "INVALID ENTRY"
    details
  end

  def data
    PianoSearch::PianoListing.reset
    scrape = PianoSearch::Scraper.new(@search_choice)
    headlines
  end

  def headlines
    PianoSearch::PianoListing.headlines
    details
  end

  def details
    puts "Enter [#]=post  [m]=MENU  [x]=exit"
    @post_choice = gets.strip
    @int = @post_choice.to_i-1
    if @int.between?(0,PianoSearch::PianoListing.all.size);
      PianoSearch::PianoListing.detail(@int)
      details
    elsif @post_choice.to_s == "m"; menu
    elsif @post_choice.to_s == "x"; exit
    else 
      invalid
      headlines
    end
  end
  
  def exit
    puts "🎹 Thank you for using Piano-Search! 🎹"
    Kernel.exit
  end

end