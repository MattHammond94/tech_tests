class LetterCounter
  def initialize(text)
    @text = text
  end

  def calculate_most_common()
    counter = Hash.new(0)
    @text.chars.each do |char|
      next unless is_letter?(char)
      counter[char] += 1
    end
    return counter.max_by { |k, v| v }.reverse
  end

  private

  def is_letter?(letter)
    return letter =~ /[a-z]/i
  end
end
