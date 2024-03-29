require 'change_calculator'

RSpec.describe ChangeCalculator do
  subject(:change_calculator) { described_class.new }

  it 'returns empty list when amount requested is 0' do
    expect(change_calculator.coins_needed(amount: 0)).to eq([])
  end

  it 'returns exactly one coin, of the correct denominiation, if that is the amount requested' do
    [1,2,5,10,20,50,100,200].each do |coin_value|
      expect(change_calculator.coins_needed(amount: coin_value)).to eq([coin_value])
    end
  end

  it 'combines multiple coins to build the requested amount' do
    expect(change_calculator.coins_needed(amount: 163)).to eq([100, 50, 10, 2, 1])
  end

  it 'combines multiple coins to build the requested amount' do
    expect(change_calculator.coins_needed(amount: 37)).to eq([20, 10, 5, 2])
  end

  it 'combines multiple coins to build the requested amount' do
    expect(change_calculator.coins_needed(amount: 15)).to eq([10, 5])
  end

  it 'combines multiple coins to build the requested amount' do
    expect(change_calculator.coins_needed(amount: 202)).to eq([200, 2])
  end

  it 'combines multiple coins to build the requested amount' do
    expect(change_calculator.coins_needed(amount: 500)).to eq([200, 200, 100])
  end

  it 'combines multiple coins to build the requested amount' do
    expect(change_calculator.coins_needed(amount: 1000)).to eq([200, 200, 200, 100, 100, 100, 50, 50])
  end
  
  it 'Should raise an error when the user requests an amount that exceeds available coins' do 
    expect{ (change_calculator.coins_needed(amount: 1200)) }.to raise_error(StandardError)
  end

  it 'Should raise an error after multiple requests are made back to back exceeding the available coins' do 
    change_calculator.coins_needed(amount: 500)
    change_calculator.coins_needed(amount: 500)
    expect{ (change_calculator.coins_needed(amount: 500)) }.to raise_error(StandardError)
  end

  it 'Should return the correct amount after multiple requests are made but coins are still available' do 
    change_calculator.coins_needed(amount: 600)
    change_calculator.coins_needed(amount: 300)
    expect(change_calculator.coins_needed(amount: 103)).to eq ([50, 50, 2, 1])
  end
end