require 'rspec'
require 'hand'
require 'poker'

describe Hand do
  subject(:new_hand) {Hand.new}

  it "always has fewer than 6 cards" do
    new_hand.cards.count.should <= 5
  end

  describe "#discard"
  describe "rank_cards"


end