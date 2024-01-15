class VowelRemover
  def initialize(text)
    @text = text
    @vowels = ["a", "e", "i", "o", "u"]
  end

  def remove_vowels
    i = 0
    while i < @text.length
      # binding.irb
      puts "Text length = #{@text.length}"

      if @vowels.include? @text[i].downcase
        puts "Text here is #{@text}"
        puts i 
        puts @text[i]

        puts @text.slice(0, i)
        puts @text.slice(i+1..-1)

        puts "---------------------"

        @text = @text.slice(0, i) + @text.slice(i+1..-1)
      else
        i += 1
      end
    end
    return @text
  end
end
