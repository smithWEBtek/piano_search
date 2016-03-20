class PianoSearch::PianoListing
  attr_accessor :price, :headline, :location, :description, :url 
  @@all = []

  def initialize
    @@all << self
  end

  def all
    @@all
  end

  def all
    @@all = all
  end

  def self.reset
    @@all.clear
  end

  def self.display_headlines
   @@all.each_with_index do |p,i|
    puts "#{i+1}:  #{p.price} #{p.headline}"
    end
    @@all.size
  end

  def self.display_user_choice(input)
    puts "-------------------------------------------------------------"
    puts @@all[input].price
    puts @@all[input].headline
    puts @@all[input].location
    puts @@all[input].description
    self.reset
    puts ""
    puts ""
  end

end