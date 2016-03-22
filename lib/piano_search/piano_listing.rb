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

end