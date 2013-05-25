class Hand
  attr_accessor :cards, :highest_rank, :top_values, :tiebreaker
  
  RANKINGS = [:high_card, :one_pair, :two_pair, :three_kind, :straight, :flush,
              :full_house, :four_kind, :straight_flush]

  def initialize
    @cards = []
    @highest_rank = :high_card
    @top_values = []
  end

  def rank
    numbers = Hash.new(0)
    suits = Hash.new(0)

    @cards.each do |card|
      numbers[card.value] += 1
      suits[card.suit] += 1
    end

    check_for_pair_through_three(numbers)
    check_for_straight(numbers)
    check_for_flush(suits, numbers)
    check_for_full_house(numbers)
    check_for_four(numbers)
    check_for_straight_flush(suits, numbers)

    @tiebreaker = (numbers.keys - @top_values).sort.reverse
    # find tiebreaker at end by subtracting top values from values, then sort.reverse
    # (FH doesn't have extra cards though)

  end

  def check_for_straight_flush(suits, numbers)
    suits_to_check = suits.keys
    vals_to_check = numbers.keys.uniq.sort

    flush = false
    if suits_to_check.uniq.count == 1
      flush = true
    end

    straight = false
    if vals_to_check.count == @cards.count
      straight = true
      vals_to_check.each_with_index do |value, index|
        next if index == vals_to_check.count - 1
        next_card = vals_to_check[index + 1]
        unless value == next_card - 1
          straight = false
        end
      end
    end

    if straight && flush
      @highest_rank = :straight_flush
      @top_values = vals_to_check.reverse
    end
  end

  def check_for_four(numbers)
    fours = check_for_mults(numbers)[2]
    if fours.count == 1
      @highest_rank = :four_kind
      @top_values = fours
    end
  end

  def check_for_full_house(numbers)
    pairs, threes = check_for_mults(numbers)
    pairs.sort!

    pair = false
    three = false

    if pairs.count == 1
      pair = true
    end
    if threes.count == 1
      three = true
    end
    
    if pair && three
      @highest_rank = :full_house
      @top_values = [threes[0], pairs[0]]
    end
  end

  def check_for_flush(suits, numbers)
    suits_to_check = suits.keys
    if suits_to_check.uniq.count == 1
      @highest_rank = :flush
      @top_values = numbers.keys.sort.reverse
    end
  end

  def check_for_straight(numbers)
    vals_to_check = numbers.keys.uniq.sort
    straight = false
    if vals_to_check.count == @cards.count
      straight = true
      vals_to_check.each_with_index do |value, index|
        next if index == vals_to_check.count - 1
        next_card = vals_to_check[index + 1]

        unless value == next_card - 1
          straight = false
        end
      end

      if straight == true
        @highest_rank = :straight
        @top_values = vals_to_check.sort.reverse
      end
    end
    # if vals_to_check.uniq.length == vals_to_check.length
  end

  def check_for_pairs(pairs)
    if pairs.count == 1
      @highest_rank = :one_pair
      @top_values = pairs
    elsif pairs.count == 2
      @highest_rank = :two_pair
      @top_values = pairs.reverse #so highest pair value is first
    end
  end

  def check_for_three(threes)
    if threes.count == 1
      @highest_rank = :three_kind
      @top_values = threes
    end
  end

  def check_for_pair_through_three(numbers)
    
    pairs, threes = check_for_mults(numbers)
    pairs.sort!

    check_for_pairs(pairs)
    check_for_three(threes)
    
    # puts "top v : #{@top_values}"
    #check pairs and threes for FH?
    #do fours later, check in order
  end

  def check_for_mults(numbers)
    pairs = []
    threes = []
    fours = []

    numbers.each do |value, amount|
      if amount == 2
        pairs << value
      elsif amount == 3
        threes << value
      elsif amount == 4
        fours << value
      end
    end
    [pairs, threes, fours]
  end
end
