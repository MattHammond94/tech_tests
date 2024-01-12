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
    error_catcher(roll, score)

    if roll == 2 || (roll == 1 && score == 10)
      @current_frame += 1
    end
  end

  def calculate_score 
    @bonus_points + @total_score
  end

  private 

  def error_catcher(roll, score)
    if !(roll.is_a?(Integer)) || !score.is_a?(Integer)
      error = "Score and roll must be Integer data types."
    elsif score > 10
      error = "Score cannot exceed 10 in one roll"
    elsif roll > 2
      error = "Roll cannot be greater than 2 on a standard frame."
    else 
      error = ""
    end

    raise ArgumentError.new(error) if !error.empty?
  end
end