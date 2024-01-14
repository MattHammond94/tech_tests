require 'scorecard'

RSpec.describe Scorecard do
  before(:each) do
    @scorecard = Scorecard.new
  end

  describe 'Adding a frame' do
    context 'When a valid frame is added' do 
      it 'Should successfully add the frame without error' do
        expect { @scorecard.add_frame(1, 4) }.not_to raise_error
      end

      it 'Should increase the frame count after two frames have been played' do
        @scorecard.add_frame(1, 4)
        @scorecard.add_frame(2, 4)
        expect(@scorecard.current_frame).to eq(2)
      end

      it 'Should increase the frame count if a strike has been played' do 
        @scorecard.add_frame(1, 10)
        expect(@scorecard.current_frame).to eq(2)
      end
    end

    context 'When the frame is invalid' do 
      it 'Should return an error if the frame includes a score that is invalid' do 
        expect { @scorecard.add_frame(1, 11) }.to raise_error(ArgumentError, "Score cannot exceed 10 in one roll")
      end

      it "Should return an error if the frame includes a roll thats invalid." do
        @scorecard.add_frame(1, 4)
        @scorecard.add_frame(2, 4)
        expect { @scorecard.add_frame(3, 4) }.to raise_error(ArgumentError, "Roll cannot be greater than 2 on a standard frame.")
      end

      it 'Should return an error if the frame is passed a roll thats not an integer.' do 
        expect{ (@scorecard.add_frame("1", 4)) }.to raise_error(ArgumentError, "Score and roll must be Integer data types.")
      end

      it 'Should return an error if the frame is passed a score that is not an integer.' do
        expect{ (@scorecard.add_frame(1, "4")) }.to raise_error(ArgumentError, "Score and roll must be Integer data types.")
      end

      it 'Should return an error if the frame is passed a score that is not an integer.' do
        expect{ (@scorecard.add_frame(nil, nil)) }.to raise_error(ArgumentError, "Score and roll must be Integer data types.")
      end
    end

    
    # Need to add logic for the possibility of a third round on bonus frame. 
    # Check that no error is returned on final round if there IS a bonus round 
    # Check there is an error if there IS a bonus round but roll is greater than 3
  end

  context 'Calculating a score' do 
    it 'Should return a score of 0 if no frames have been added.' do 
      expect(@scorecard.calculate_score).to eq(0)
    end

    it 'Should return the correct score after a frame has been added' do
      @scorecard.add_frame(1, 4)
      expect(@scorecard.calculate_score).to eq(4)
    end

    it 'Should return the correct score after a set amount of frames.' do
      @scorecard.add_frame(1, 4)
      @scorecard.add_frame(2, 4)
      @scorecard.add_frame(1, 6)
      @scorecard.add_frame(2, 1)
      @scorecard.add_frame(1, 3)
      expect(@scorecard.calculate_score).to eq(18)
    end

    it 'Should return the correct score after a strike has been played' do
      @scorecard.add_frame(1, 10)
      @scorecard.add_frame(1, 4)
      @scorecard.add_frame(2, 5)
      expect(@scorecard.calculate_score).to eq(28)
    end

    it 'Should return the correct score after a spare has been played' do 
      @scorecard.add_frame(1, 3)
      @scorecard.add_frame(2, 7)
      @scorecard.add_frame(1, 6)
      @scorecard.add_frame(2, 2)
      expect(@scorecard.calculate_score).to eq(24)
    end

    it 'Should return the correct score after multiple strikes has been played' do
      @scorecard.add_frame(1, 10)
      @scorecard.add_frame(1, 4)
      @scorecard.add_frame(2, 5)
      @scorecard.add_frame(1, 10)
      @scorecard.add_frame(1, 6)
      @scorecard.add_frame(2, 2)
      @scorecard.add_frame(1, 3) 
      @scorecard.add_frame(2, 3)
      expect(@scorecard.calculate_score).to eq(60)
    end

    it 'Should return the correct score after multiple spares has been played' do 
      @scorecard.add_frame(1, 3)
      @scorecard.add_frame(2, 7)
      @scorecard.add_frame(1, 6)
      @scorecard.add_frame(2, 2)
      @scorecard.add_frame(1, 5)
      @scorecard.add_frame(2, 5)
      @scorecard.add_frame(1, 2)
      @scorecard.add_frame(2, 3)
      expect(@scorecard.calculate_score).to eq(41)
    end

    it 'Should return the correct score when a strike has been followed by a spare' do 
      @scorecard.add_frame(1, 10)
      @scorecard.add_frame(1, 5)
      @scorecard.add_frame(2, 5)
      @scorecard.add_frame(1, 2)
      @scorecard.add_frame(2, 3)
      expect(@scorecard.calculate_score).to eq(37)
    end

    it 'Should return the correct score when a spare has been followed by a strike' do 
      @scorecard.add_frame(1, 5)
      @scorecard.add_frame(2, 5)
      @scorecard.add_frame(1, 10)
      @scorecard.add_frame(1, 2)
      @scorecard.add_frame(1, 3)
      expect(@scorecard.calculate_score).to eq(40)
    end

    it 'Should return the correct result after two consecutive spares.' do 
      @scorecard.add_frame(1, 5)
      @scorecard.add_frame(2, 5)
      @scorecard.add_frame(1, 3)
      @scorecard.add_frame(2, 7)
      expect(@scorecard.calculate_score).to eq(23)
    end

    it 'Should return the correct result after a few rounds are played at random' do 
      @scorecard.add_frame(1, 1)
      @scorecard.add_frame(2, 4)
      @scorecard.add_frame(1, 4)
      @scorecard.add_frame(2, 5)
      @scorecard.add_frame(1, 6)
      @scorecard.add_frame(2, 4)
      @scorecard.add_frame(1, 5)
      @scorecard.add_frame(2, 5)
      @scorecard.add_frame(1, 10)
      @scorecard.add_frame(1, 0)
      @scorecard.add_frame(2, 1)
      expect(@scorecard.calculate_score).to eq(61)
    end

    it 'Should return the correct result after four consecutive strikes.' do 
      @scorecard.add_frame(1, 10)
      p "bonus: #{@scorecard.bonus_points}"
      p "total: #{@scorecard.total_score}"
      p "New frame"
      p "Current strike streak: #{@scorecard.strike_streak}"
      @scorecard.add_frame(1, 10)
      p "bonus: #{@scorecard.bonus_points}"
      p "total: #{@scorecard.total_score}"
      p "Current strike streak: #{@scorecard.strike_streak}"
      p "New frame"
      @scorecard.add_frame(1, 10)
      p "bonus: #{@scorecard.bonus_points}"
      p "total: #{@scorecard.total_score}"
      p "New frame"
      p "Current strike streak: #{@scorecard.strike_streak}"
      @scorecard.add_frame(1, 10)
      p "bonus: #{@scorecard.bonus_points}"
      p "total: #{@scorecard.total_score}"
      p "New frame"
      p "Current strike streak: #{@scorecard.strike_streak}"
      expect(@scorecard.calculate_score).to eq(90)
    end

    # it 'Should return the correct score when a perfect game has been played' do 
    #   @scorecard.add_frame(1, 10)
    #   @scorecard.add_frame(1, 10)
    #   @scorecard.add_frame(1, 10)
    #   @scorecard.add_frame(1, 10)
    #   @scorecard.add_frame(1, 10)
    #   @scorecard.add_frame(1, 10)
    #   @scorecard.add_frame(1, 10)
    #   @scorecard.add_frame(1, 10)
    #   @scorecard.add_frame(1, 10)
    #   @scorecard.add_frame(1, 10)
    #   @scorecard.add_frame(1, 10)
    #   @scorecard.add_frame(1, 10)
    #   expect(@scorecard.calculate_score).to eq(300)
    # end

    # Full spare game

    # Normal game with a strike final round

    # Normal game with a spare final round 

    # Gutter game 

  end
end