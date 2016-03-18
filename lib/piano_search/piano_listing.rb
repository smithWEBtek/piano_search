class PianoSearch::PianoListing
  attr_accessor :all, :price, :headline, :location, :description, :url 
  @@all = []

  def initialize
    @@all << self
  end

  def all
    @@all
  end

  def display
   @@all.each_with_index do |p,i|
    puts "#{i+1}: #{p.price}......#{p.headling}"
    end
binding.pry
  end

end