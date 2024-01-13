class Scorecard

  attr_reader :current_frame, :total_score, :bonus_points

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

    if @spare_round && roll == 1
      @bonus_points += score
      @active_frame_score += score
      @spare_round = false
    end

    if @strike_round
      @bonus_points += score
    end

    if @strike_round && roll == 2
      @strike_round = false
    end

    if roll == 1 && score == 10
      strike
    elsif roll == 2 && @active_frame_score + score == 10
      spare(score)
    else
      # STANDARD ROLL
      @active_frame_score += score
      @total_score += score
    end

    if roll == 2
      end_frame
    end
  end

  def calculate_score 
    @bonus_points + @total_score
  end

  private

  def strike 
    @total_score += 10
    @current_frame += 1
    @strike_round = true
  end

  def spare(score)
    @total_score += score 
    @active_frame_score = 0
    @spare_round = true
  end

  def end_frame
    @current_frame += 1
    @active_frame_score = 0
  end

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