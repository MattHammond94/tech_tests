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

  #   it 'Should return the correct score after a spare has been played' do 
  #     scorecard = Scorecard.new
  #     scorecard.add_frame(1, 10)
  #     expect(scorecard.calculate_score).to eq()
  #   end

    # Score after multiple strikes

    # Score after multiple spares 

    # Perfect game (Round 10 strike)

    # Gutter game 

    # Round 10 spare 
  end
end