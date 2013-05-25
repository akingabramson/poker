require 'rspec'
require 'poker'
require 'hand'

describe Game do 
  subject(:new_game) {Game.new("Asher", "John", "Ned")}

  describe "#initialize" do
    it "makes x new players" do
      new_game.players.count.should == 3
    end
  end

  describe "#play_hand" do
    it "deals 5 cards to each player" do
      pending
      should_receive(:deal_cards).exactly(1).times
    end

    it "takes bets" do 
      pending
      should_receive(:take_bets).at_least(1).times
    end

    it "deletes discards from hand, deals new card"
    it "takes bets"
    it "reveals hands, hands are ranked"
  end

  describe "#deal_cards" do
    before(:each) do 
      deck = Deck.new
      new_game.deal_cards(deck)
    end

    it "deals 5 cards to each player" do 
      new_game.players.sample.hand.cards.count.should == 5
    end
  end

  describe "#compare" do
    it "chooses a winner from multiple hands" do 
      a = [Card.new(14, :spades), Card.new(14, :hearts),
       Card.new(2, :diamonds), Card.new(3, :diamonds), Card.new(4, :diamonds)]
      b =  [Card.new(14, :spades), Card.new(13, :hearts),
       Card.new(2, :diamonds), Card.new(3, :diamonds), Card.new(4, :diamonds)]
      c =  [Card.new(13, :spades), Card.new(13, :hearts),
       Card.new(2, :diamonds), Card.new(3, :diamonds), Card.new(4, :diamonds)]
      Game.new.compare(a,b,c).should == a
    end

    it "compares straights to flushes and three of a kind" do
      a = [Card.new(14, :spades), Card.new(13, :hearts),
       Card.new(12, :diamonds), Card.new(11, :diamonds), Card.new(10, :diamonds)]
      b =  [Card.new(14, :spades), Card.new(13, :spades),
       Card.new(2, :spades), Card.new(3, :spades), Card.new(4, :spades)]
      c =  [Card.new(13, :spades), Card.new(13, :hearts),
       Card.new(13, :clubs), Card.new(3, :diamonds), Card.new(4, :diamonds)]
      
      Game.new.compare(a,b,c).should == a
    end

    it "knows that full house beats three of a kind" do
      b =  [Card.new(14, :spades), Card.new(14, :spades),
       Card.new(7, :clubs), Card.new(7, :clubs), Card.new(7, :clubs)]
      c =  [Card.new(13, :spades), Card.new(13, :hearts),
       Card.new(13, :clubs), Card.new(3, :diamonds), Card.new(4, :diamonds)]
       
      Game.new.compare(b,c).should == b
    end

    it "picks the higher value cards in the event of a tie" do 
      a = [Card.new(10, :spades), Card.new(13, :hearts),
       Card.new(12, :diamonds), Card.new(11, :diamonds), Card.new(10, :diamonds)]
      b =  [Card.new(11, :spades), Card.new(11, :spades),
       Card.new(2, :spades), Card.new(3, :spades), Card.new(4, :spades)]
      c =  [Card.new(12, :spades), Card.new(12, :hearts),
       Card.new(13, :clubs), Card.new(3, :diamonds), Card.new(4, :diamonds)]
      
      Game.new.compare(a,b,c).should == c
    end

    it "picks three of a kind over two pair" do
      b =  [Card.new(11, :spades), Card.new(11, :spades),
       Card.new(2, :spades), Card.new(2, :spades), Card.new(4, :spades)]
      c =  [Card.new(12, :spades), Card.new(12, :hearts),
       Card.new(12, :clubs), Card.new(3, :diamonds), Card.new(4, :diamonds)]
       
       Game.new.compare(b,c).should == c
    end

  end
end



describe Card do
  subject(:ace_sp) {Card.new(14, :spades)}

  it "has getters for suit and value" do
    ace_sp.value.should == 14
    ace_sp.suit.should == :spades
  end
end

describe Deck do
  subject(:sample_deck) {Deck.new}
  
  it "initializes to 52 cards" do
    sample_deck.cards.count.should == 52
  end

  describe "#deal" do 

    it "shouldn't be in the remaining cards" do
      card = sample_deck.deal
      sample_deck.cards.count.should < 52
    end
  end

end

describe Player do
  it "holds a hand"
end