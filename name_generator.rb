module Enumerable
  def sum
    inject(&:+)
  end
end

class DiscreteProbabilityDistribution < Hash
  def cumulative_densities
    result = {}
    inject(0) do |total, (x, n)|
      result[x] = total + n
    end
    result
  end

  def sample
    cds = cumulative_densities
    m = rand(cds.values.max)
    cds.find{|x, n| n > m }.first
  end
end

class NameGenerator
  def initialize(text)
    @transitions = Hash.new{ |h,k| h[k] = DiscreteProbabilityDistribution.new(0) }
    text.split('').each_cons(2) do |a, b|
      @transitions[a][b] = @transitions[a][b] + 1
    end
  end

  def next(c)
    @transitions[c].sample
  end

  def char_enum
    Enumerator.new do |y|
      c = "\n"
      loop { y << c = self.next(c) }
    end
  end

  def name
    char_enum.take_while{|c| c != "\n"}.join
  end
end
