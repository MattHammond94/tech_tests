require 'vowel_remover'
require 'letter_counter'

RSpec.describe "remove_vowels method" do
  it "removes a vowel from a simple string" do
    remover = VowelRemover.new("ab")
    result_no_vowels = remover.remove_vowels
    expect(result_no_vowels).to eq "b"
  end

  it "removes vowels from a complex string" do
    remover = VowelRemover.new("We will remove the vowels from this sentence.")
    result_no_vowels = remover.remove_vowels
    expect(result_no_vowels).to eq "W wll rmv th vwls frm ths sntnc."
  end

  it "Removes all the vowels" do 
    remover = VowelRemover.new("aeiou")
    result_no_vowels = remover.remove_vowels
    expect(result_no_vowels).to eq ""
  end

  it "Removes all the vowels from a string of multi vowels" do 
    remover = VowelRemover.new("nooooooooooope")
    result_no_vowels = remover.remove_vowels
    expect(result_no_vowels).to eq "np"
  end
end


RSpec.describe "Letter counter method" do
  it "Successfully " do
    counter = LetterCounter.new("Digital Punk")
    result = counter.calculate_most_common
    expect(result).to eq([2, "i"])
  end
end