class Scorecard

  attr_reader :current_frame, :total_score, :bonus_points, :strike_streak, :active_frame_score

  def initialize
    @current_frame = 1
    @total_score = 0
    @active_frame_score = 0
    @bonus_points = 0
    @strike_round = false
    @spare_round = false
    @strike_streak = 0
  end

  def add_frame(roll, score)
    error_catcher(roll, score)

    # Set a new game (reset all counts) if @current_frame >= 13 

    new_game(roll)

    if @current_frame == 11 && roll == 1 && score == 10
      return strike
    elsif @current_frame == 12 && roll == 1 && score == 10
      @bonus_points += 10 
      return strike
    elsif @current_frame == 11 && @spare_round 
      return @bonus_points += score
    else 
      "else2"
    end

    if @spare_round && roll == 1
      @bonus_points += score
      @spare_round = false
    end

    if @strike_round && score == 10
      @strike_streak > 1 ? @bonus_points += 10 : nil
      @bonus_points += 10
      return strike
    elsif @strike_round && roll == 2
      @bonus_points += score
      @strike_round = false
      @strike_streak = 0
    elsif @strike_round
      @bonus_points += score
    end

    if roll == 1 && score == 10
      return strike
    elsif roll == 2 && @active_frame_score + score == 10
      spare(score)
    else
      standard_roll(score)
    end

    if roll == 2
      end_frame
    end
  end

  def calculate_score 
    @bonus_points + @total_score
  end

  private

  def new_game(roll)
    if @current_frame >= 14
      reset_game
    elsif @current_frame == 11 && !@strike_round && !@spare_round
      reset_game
    else
      "else"
    end
  end

  def reset_game
    @current_frame = 1
    @total_score = 0
    @active_frame_score = 0
    @bonus_points = 0
  end 

  def strike
    @total_score += 10
    @current_frame += 1
    @strike_streak += 1
    @strike_round = true
  end

  def spare(score)
    @total_score += score 
    @active_frame_score = 0
    @spare_round = true
  end

  def standard_roll(score)
    @active_frame_score += score
    @total_score += score
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