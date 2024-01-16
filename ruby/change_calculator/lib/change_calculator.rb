class ChangeCalculator
  def initialize
    @current_denominations = {
      200 => 3,
      100 => 3,
      50 => 3,
      20 => 3,
      10 => 3,
      5 => 3,
      2 => 3,
      1 => 3
    }
  end

  def coins_needed(amount:)
    return [] if amount.zero?
    raise StandardError.new("Value exceeds available coins.") if amount > available_amount

    required_coins = []

    @current_denominations.keys.each do |available_coin|
      iterations = (amount / available_coin)
      individual_availabile = iterations > @current_denominations[available_coin]
      individual_availabile ? amount -= available_coin * @current_denominations[available_coin] : amount -= available_coin * iterations
      individual_availabile ? @current_denominations[available_coin].times { required_coins << available_coin } : iterations.times { required_coins << available_coin }
      individual_availabile ? @current_denominations[available_coin] = 0 : @current_denominations[available_coin] -= iterations
    end
    required_coins
  end

  private 

  def available_amount 
    @current_denominations.map { |k, v| k * v }.sum
  end
end