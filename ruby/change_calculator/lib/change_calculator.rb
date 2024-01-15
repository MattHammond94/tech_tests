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
      1 => 3,
    }
  end

  def coins_needed(amount:)
    return [] if amount.zero?
    raise StandardError.new("Value exceeds available coins.") if amount > @current_denominations.map { |k, v| k * v }.sum
    return [amount] if available_coins.include?(amount)

    required_coins = []

    available_coins.each do |available_coin|

      if amount >= available_coin 

        iterations = (amount / available_coin)

        iterations.times { required_coins << available_coin }

        amount -= available_coin * iterations

        puts amount
      end
      
    end
    p required_coins
    required_coins
  end

  private

  DENOMINATIONS = [
    200,
    100,
     50,
     20,
     10,
      5,
      2,
      1,
  ].freeze
  private_constant :DENOMINATIONS

  def available_coins
    DENOMINATIONS
  end
end