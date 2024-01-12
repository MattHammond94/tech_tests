class Scorecard

  attr_reader :current_frame

  def initialize
    @current_frame = 1
    @total_score = 0
    @active_frame_score = 0
    @bonus_points = 0
    @strike_round = false
    @spare_round = false
  end

  def add_frame(roll, score)
    raise ArgumentError.new("Score cannot exceed 10 in one roll") if score > 10
    raise ArgumentError.new("Roll cannot be greater than 2 on a standard frame.") if roll > 2
    
    if roll == 2 || (roll == 1 && score == 10)
      @current_frame += 1
    end
  end

  def calculate_score 
    @bonus_points + @total_score
  end
end