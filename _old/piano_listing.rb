class PianoSearch::PianoListing
  attr_accessor :url, :price, :headline, :location, :description

  def initialize
    @@all << self
  end
end