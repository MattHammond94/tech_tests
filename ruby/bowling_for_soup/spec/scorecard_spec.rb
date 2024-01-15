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
        @scorecard.add_frame(1, 4)
        @scorecard.add_frame(2, 4)
        expect(@scorecard.current_frame).to eq(3)
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

    it 'Should return the correct result after nine consecutive strikes.' do 
      @scorecard.add_frame(1, 10)
      @scorecard.add_frame(1, 10)
      @scorecard.add_frame(1, 10)
      @scorecard.add_frame(1, 10)
      @scorecard.add_frame(1, 10)
      @scorecard.add_frame(1, 10)
      @scorecard.add_frame(1, 10)
      @scorecard.add_frame(1, 10)
      @scorecard.add_frame(1, 10)
      expect(@scorecard.calculate_score).to eq(240)
    end

    it 'Should return the correct score when a perfect game has been played' do 
      @scorecard.add_frame(1, 10)
      @scorecard.add_frame(1, 10)
      @scorecard.add_frame(1, 10)
      @scorecard.add_frame(1, 10)
      @scorecard.add_frame(1, 10)
      @scorecard.add_frame(1, 10)
      @scorecard.add_frame(1, 10)
      @scorecard.add_frame(1, 10)
      @scorecard.add_frame(1, 10)
      @scorecard.add_frame(1, 10)
      @scorecard.add_frame(1, 10)
      @scorecard.add_frame(1, 10)
      p "Is this complete? : #{@scorecard.current_frame}"
      expect(@scorecard.calculate_score).to eq(300)
    end

    it 'Should return the correct score after a full game of spares and one bonus round' do
      @scorecard.add_frame(1, 5)
      @scorecard.add_frame(2, 5)
      @scorecard.add_frame(1, 5)
      @scorecard.add_frame(2, 5)
      @scorecard.add_frame(1, 5)
      @scorecard.add_frame(2, 5)
      @scorecard.add_frame(1, 5)
      @scorecard.add_frame(2, 5)
      @scorecard.add_frame(1, 5)
      @scorecard.add_frame(2, 5)
      @scorecard.add_frame(1, 5)
      @scorecard.add_frame(2, 5)
      @scorecard.add_frame(1, 5)
      @scorecard.add_frame(2, 5)
      @scorecard.add_frame(1, 5)
      @scorecard.add_frame(2, 5)
      @scorecard.add_frame(1, 5)
      @scorecard.add_frame(2, 5)
      @scorecard.add_frame(1, 5)
      @scorecard.add_frame(2, 5)
      @scorecard.add_frame(1, 3)
      expect(@scorecard.calculate_score).to eq(148)
    end

    it 'Should return the correct score when 10 strikes are followed by a normal bonus round' do 
      @scorecard.add_frame(1, 10)
      @scorecard.add_frame(1, 10)
      @scorecard.add_frame(1, 10)
      @scorecard.add_frame(1, 10)
      @scorecard.add_frame(1, 10)
      @scorecard.add_frame(1, 10)
      @scorecard.add_frame(1, 10)
      @scorecard.add_frame(1, 10)
      @scorecard.add_frame(1, 10)
      @scorecard.add_frame(1, 10)
      @scorecard.add_frame(1, 4)
      @scorecard.add_frame(2, 3)
      p "Is this complete? : #{@scorecard.current_frame}"
      expect(@scorecard.calculate_score).to eq(281)
    end

    # Normal game with a strike final round
    it 'Should return the correct score after a full game with the final round being a strike causing two bonus rounds' do
      @scorecard.add_frame(1, 2)
      @scorecard.add_frame(2, 4)
      @scorecard.add_frame(1, 2)
      @scorecard.add_frame(2, 5)
      @scorecard.add_frame(1, 2)
      @scorecard.add_frame(2, 4)
      @scorecard.add_frame(1, 2)
      @scorecard.add_frame(2, 2)
      @scorecard.add_frame(1, 2)
      @scorecard.add_frame(2, 1)
      @scorecard.add_frame(1, 2)
      @scorecard.add_frame(2, 2)
      @scorecard.add_frame(1, 2)
      @scorecard.add_frame(2, 1)
      @scorecard.add_frame(1, 2)
      @scorecard.add_frame(2, 2)
      @scorecard.add_frame(1, 7)
      @scorecard.add_frame(2, 2)
      p "Score after the 9th frame: #{@scorecard.calculate_score}"
      @scorecard.add_frame(1, 10)
      p "Score after the 10th frame: #{@scorecard.calculate_score} - Correct score 56!"
      p "Current frame after 10th: #{@scorecard.current_frame}"
      p "Is it a strike round?: #{@scorecard.strike_round}"
      p "Is there a streak? #{@scorecard.strike_streak}"
      @scorecard.add_frame(1, 3)
      p "is it still a strike round now? #{@scorecard.strike_round}"
      p "Score after the 10th frame: #{@scorecard.calculate_score}"
      @scorecard.add_frame(2, 4)
      p "game complete: The current frame is: #{@scorecard.current_frame}"
      expect(@scorecard.calculate_score).to eq(63)
    end

    # it 'Should return the correct result after a full game is played at random' do 
    #   @scorecard.add_frame(1, 3)
    #   @scorecard.add_frame(2, 3)
    #   # 1
    #   @scorecard.add_frame(1, 5)
    #   @scorecard.add_frame(2, 5)
    #   # 2
    #   @scorecard.add_frame(1, 10)
    #   # 3
    #   @scorecard.add_frame(1, 4)
    #   @scorecard.add_frame(2, 3)
    #   p "Score at round 4: #{@scorecard.calculate_score}" # Should equal 50
    #   # 4
    #   @scorecard.add_frame(1, 10)
    #   # 5
    #   @scorecard.add_frame(1, 10)
    #   # 6
    #   p "Score at round 6: #{@scorecard.calculate_score}" # Should equal 80
    #   # p "Strike streak after 2 strikes: #{@scorecard.strike_streak}"
    #   @scorecard.add_frame(1, 4)
    #   # p "Is it a strike round tho? : #{@scorecard.strike_round}"
    #   # p "Strike streak after the strikes and next round: #{@scorecard.strike_streak}"
    #   # p "Whats the score here? #{@scorecard.calculate_score}  - This is between round 6 and round 7 where 4 is rolled"
    #   @scorecard.add_frame(2, 1)
    #   p "Score at round 7: #{@scorecard.calculate_score}  - Should equal 94" # Should equal 94   <= Here is where the bug occurs. Missing 4
    #   # p "It shouldn't be a strike round here: #{@scorecard.strike_round}"
    #   # p "And there should no longer be a strike streak: #{@scorecard.strike_streak}"
    #   # 7
    #   @scorecard.add_frame(1, 4)
    #   @scorecard.add_frame(2, 4)
    #   # p "Score at round 8: #{@scorecard.calculate_score}" 
    #   # 8
    #   @scorecard.add_frame(1, 5)
    #   @scorecard.add_frame(2, 5)
    #   p "Score at round 9: #{@scorecard.calculate_score}" 
    #   # 9 
    #   @scorecard.add_frame(1, 1)
    #   @scorecard.add_frame(2, 0)
    #   p "This is the current frame: #{@scorecard.current_frame}"
    #   expect(@scorecard.calculate_score).to eq(114)
    # end

    # A test for 9 strikes, a spare in the final(10th) and a normal roll in final round.

    # Normal game with a spare final round 
    it 'Should return the correct score after a full game with the final round being a spare causing one bonus round' do
      @scorecard.add_frame(1, 2)
      @scorecard.add_frame(2, 4)
      @scorecard.add_frame(1, 2)
      @scorecard.add_frame(2, 5)
      @scorecard.add_frame(1, 2)
      @scorecard.add_frame(2, 4)
      @scorecard.add_frame(1, 2)
      @scorecard.add_frame(2, 2)
      @scorecard.add_frame(1, 2)
      @scorecard.add_frame(2, 1)
      @scorecard.add_frame(1, 2)
      @scorecard.add_frame(2, 2)
      @scorecard.add_frame(1, 2)
      @scorecard.add_frame(2, 1)
      @scorecard.add_frame(1, 2)
      @scorecard.add_frame(2, 2)
      @scorecard.add_frame(1, 7)
      @scorecard.add_frame(2, 2)
      @scorecard.add_frame(1, 2)
      @scorecard.add_frame(2, 8)
      @scorecard.add_frame(1, 4)
      p "Is this complete? : #{@scorecard.current_frame}"
      expect(@scorecard.calculate_score).to eq(60)
    end

    # Reporting live from the gutter:
    it 'Should return the correct score after a full game with the final round being a spare causing one bonus round' do
      @scorecard.add_frame(1, 0)
      @scorecard.add_frame(2, 0)
      @scorecard.add_frame(1, 0)
      @scorecard.add_frame(2, 0)
      @scorecard.add_frame(1, 0)
      @scorecard.add_frame(2, 0)
      @scorecard.add_frame(1, 0)
      @scorecard.add_frame(2, 0)
      @scorecard.add_frame(1, 0)
      @scorecard.add_frame(2, 0)
      @scorecard.add_frame(1, 0)
      @scorecard.add_frame(2, 0)
      @scorecard.add_frame(1, 0)
      @scorecard.add_frame(2, 0)
      @scorecard.add_frame(1, 0)
      @scorecard.add_frame(2, 0)
      @scorecard.add_frame(1, 0)
      @scorecard.add_frame(2, 0)
      @scorecard.add_frame(1, 0)
      @scorecard.add_frame(2, 0)
      p "Is this complete? : #{@scorecard.current_frame}"
      expect(@scorecard.calculate_score).to eq(0)
    end
  end




  context 'When a game has been completed' do 
    # it 'Should successfully reset the score after a standard game (No bonus rounds) are played' do
    #   @scorecard.add_frame(1, 2)
    #   @scorecard.add_frame(2, 2)
    #   @scorecard.add_frame(1, 2)
    #   @scorecard.add_frame(2, 2)
    #   @scorecard.add_frame(1, 2)
    #   @scorecard.add_frame(2, 2)
    #   @scorecard.add_frame(1, 2)
    #   @scorecard.add_frame(2, 2)
    #   @scorecard.add_frame(1, 2)
    #   @scorecard.add_frame(2, 2)
    #   @scorecard.add_frame(1, 2)
    #   @scorecard.add_frame(2, 2)
    #   @scorecard.add_frame(1, 2)
    #   @scorecard.add_frame(2, 2)
    #   @scorecard.add_frame(1, 2)
    #   @scorecard.add_frame(2, 2)
    #   @scorecard.add_frame(1, 2)
    #   @scorecard.add_frame(2, 2)
    #   @scorecard.add_frame(1, 2)
    #   @scorecard.add_frame(2, 2)
    #   @scorecard.add_frame(1, 5)
    #   expect(@scorecard.current_frame).to eq(1)
    #   expect(@scorecard.bonus_points).to eq(0)
    #   expect(@scorecard.total_score).to eq(5)
    #   expect(@scorecard.active_frame_score).to eq(5)
    # end

    # it 'Should successfully reset the score after a game of 10 spares is followed by a standard bonus round' do
    #   @scorecard.add_frame(1, 5)
    #   @scorecard.add_frame(2, 5)
    #   @scorecard.add_frame(1, 5)
    #   @scorecard.add_frame(2, 5)
    #   @scorecard.add_frame(1, 5)
    #   @scorecard.add_frame(2, 5)
    #   @scorecard.add_frame(1, 5)
    #   @scorecard.add_frame(2, 5)
    #   @scorecard.add_frame(1, 5)
    #   @scorecard.add_frame(2, 5)
    #   @scorecard.add_frame(1, 5)
    #   @scorecard.add_frame(2, 5)
    #   @scorecard.add_frame(1, 5)
    #   @scorecard.add_frame(2, 5)
    #   @scorecard.add_frame(1, 5)
    #   @scorecard.add_frame(2, 5)
    #   @scorecard.add_frame(1, 5)
    #   @scorecard.add_frame(2, 5)
    #   @scorecard.add_frame(1, 5)
    #   @scorecard.add_frame(2, 5)
    #   p "current frame: #{@scorecard.current_frame}"
    #   @scorecard.add_frame(1, 5)
    #   @scorecard.add_frame(2, 5)
    #   expect(@scorecard.current_frame).to eq(1)
    #   expect(@scorecard.bonus_points).to eq(0)
    #   expect(@scorecard.total_score).to eq(5)
    #   expect(@scorecard.active_frame_score).to eq(5)
    # end

    # Need to add logic for the possibility of a third round on bonus frame. 
    # Check that no error is returned on final round if there IS a bonus round 
    # Check there is an error if there IS a bonus round but roll is greater than 3
  end
end