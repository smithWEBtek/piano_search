class PianoSearch::PianoListing
  attr_accessor :all, :price, :headline, :location, :detail, :url 
  @@all = []

  def initialize
    @@all << self
  end

  def self.all
    @@all
  end

  def self.reset
    @@all.clear
  end

  def self.headlines
   @@all.each_with_index do |p,i|
    puts "# #{i+1}:  #{p.price} #{p.headline}"
    end
  end

  def self.detail(input)
    puts "-------------------------------------------------------------"
    puts @@all[input].price
    puts @@all[input].headline
    puts @@all[input].location
    puts @@all[input].detail
    self.reset
    puts ""
    puts ""
  end

end