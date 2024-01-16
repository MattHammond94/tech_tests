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
    raise StandardError.new("Value exceeds available coins.") if amount > @current_denominations.map { |k, v| k * v }.sum
    return [amount] if @current_denominations.keys.include?(amount) && @current_denominations[amount] > 0

    required_coins = []

    @current_denominations.keys.each do |available_coin|

      if amount >= available_coin 
        iterations = (amount / available_coin)
        if iterations > @current_denominations[available_coin]
          amount -= available_coin * @current_denominations[available_coin]
          @current_denominations[available_coin].times { required_coins << available_coin }
          @current_denominations[available_coin] = 0
        else 
          amount -= available_coin * iterations
          iterations.times { required_coins << available_coin }
          @current_denominations[available_coin] -= iterations
        end 
      end
    end
    required_coins
  end

  # private

  # DENOMINATIONS = [
  #   200,
  #   100,
  #    50,
  #    20,
  #    10,
  #     5,
  #     2,
  #     1,
  # ].freeze
  # private_constant :DENOMINATIONS

  # def available_coins
  #   DENOMINATIONS
  # end
end