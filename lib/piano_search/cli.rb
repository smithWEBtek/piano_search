class PianoSearch::CLI
  attr_accessor :brand, :model, :state, :area
  def call
    start
  end

  def start
    input = nil
    puts ""
    puts "🎹  Welcome to Boston Craigslist Piano Search 🎹"

    until input == "x"
      puts "Please enter 1 for Yamaha U1, or enter 2 for Yamaha P22:"     
    input = gets.to_s.strip.downcase

      if input == "1"
        puts "Here are Yamaha U1's for sale in Boston:"
        puts ""
        puts "🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹"
        puts "#  PRICE  HEADLINE"
        puts "----------------------------------------------"
        u1
        menu

      elsif input == "2"
        puts "Here are Yamaha P22's for sale in Boston:"
        puts ""
        puts "🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹"
        puts "#  PRICE  HEADLINE"
        puts "----------------------------------------------"
        p22
        menu

      elsif input == "x"
        goodbye
      else
        puts "Invalid entry, enter a '#'' to see details,'list' to restart, or 'x' to exit."
      end
    end
  end

  def invalid
    puts "Invalid entry, please choose again."
  end

  def u1
    PianoSearch::Post.scrape_clu1
    PianoSearch::Post.show_headings
    menu
  end

  def p22
    PianoSearch::Post.scrape_clp22
    PianoSearch::Post.show_headings
    menu
  end

  def menu
    input = nil
    count = PianoSearch::Post.scrape_posts.count
      puts ""
    puts "Enter a '#'' to see details,'list' to restart, or 'x' to exit."
      puts ""
    until input == "x"
    input = gets.strip.downcase

    if input.to_i.between?(1,count)  
      puts ""
      puts "----------------------------------------------"
      puts "🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹🎹"
      PianoSearch::Post.scrape_detail
      PianoSearch::Post.show_detail(input.to_i-1)
      puts ""
      puts "----------------------------------------------"
      puts "Enter another # for details, 'list' to restart, or 'x' to exit the program."
    elsif input.to_i > count
      puts "Invalid entry, please enter a valid #, or 'list' to refresh."
    elsif input == "list"
      start
    elsif input == "x"
      goodbye
    else
      puts "Invalid entry, enter a '#'' to see details,'list' to restart, or 'x' to exit."
      end      
    end 
  end

  def goodbye
      puts ""
      puts "🎹 Thank you for using Piano-Search! 🎹"
      puts ""
      Kernel.exit
  end

end