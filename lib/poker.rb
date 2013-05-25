require_relative 'hand.rb'

class Game
  attr_reader :players

  def initialize(*player_names)
    @players = []
    player_names.each do |name|
      @players << Player.new(name)
    end
  end

  def game_loop
    until game_over?
      play_hand
    end

    puts "Game over!"
    puts "#{winning_player} won!"

  end

  def winning_player
  end

  def game_over?
  end

  def play_hand
    deck = Deck.new
    # deal_cards(deck)
    # take_bets: check how many players are left
    # get_discards: ask player which cards to change, deal new cards
    # take_bets
    # check how many players are left
    # reveal winner: each player--compare hand to other player
    # delete players who are bankrupt from @players
  end

  def deal_cards(deck)
    @players.each do |player|
      5.times do
        player.hand.cards << deck.deal
      end      
    end
  end

  def compare(*players_left)

    players_left.each do |player|
      rank = player.hand.rank


      





      #at end, check for high card
    end
  end

end

class Card
  attr_reader :value, :suit

  def initialize(value, suit)
    @value = value
    @suit = suit
  end
end

class Deck
  attr_accessor :cards

  SUITS = [:clubs, :diamonds, :hearts, :spades]
  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]

  def initialize
    @cards = []
    SUITS.each do |suit|
      VALUES.each do |value|
        @cards << Card.new(value, suit)
      end
    end
  end

  def deal
    chosen_card = @cards.sample
    @cards.delete(chosen_card)
    chosen_card
  end
end

class Player
  attr_accessor :hand, :bank, :name

  def initialize(name)
    @name = name
    @bank = 100
    @hand = Hand.new
  end
end



h = Hand.new
h.cards = [Card.new(14, :spades), Card.new(13, :diamonds),
       Card.new(6, :spades), Card.new(11, :spades), Card.new(10, :spades)]
h.rank
p h.highest_rank
p h.top_values
p h.tiebreaker