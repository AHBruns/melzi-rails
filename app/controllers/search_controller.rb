# totally a stack overflow copy paste job
# todo: clean up and simplify this mess
module StringMetrics

  class LCS
    SELF, LEFT, UP, DIAG = [0, 0], [0, -1], [-1, 0], [-1, -1]

    def initialize(a, b)
      @m = Array.new(a.length) { Array.new(b.length) }
      a.each_char.with_index do |x, i|
        b.each_char.with_index do |y, j|
          match(x, y, i, j)
        end
      end
    end

    def match(c, d, i, j)
      @i, @j = i, j
      @m[i][j] = compute_entry(c, d)
    end

    def lookup(x, y)
      [@i + x, @j + y]
    end

    def valid?(i = @i, j = @j)
      i >= 0 && j >= 0
    end

    def peek(x, y)
      i, j = lookup(x, y)
      valid?(i, j) ? @m[i][j] : 0
    end

    def compute_entry(c, d)
      c == d ? peek(*DIAG) + 1 : [peek(*LEFT), peek(*UP)].max
    end

    def backtrack
      @i, @j = @m.length - 1, @m[0].length - 1
      y = []
      y << @i + 1 if backstep? while valid?
      y.reverse
    end

    def backtrack2
      @i, @j = @m.length - 1, @m[0].length - 1
      y = []
      y << @j + 1 if backstep? while valid?
      [backtrack, y.reverse]
    end

    def backstep?
      backstep = compute_backstep
      @i, @j = lookup(*backstep)
      backstep == DIAG
    end

    def compute_backstep
      case peek(*SELF)
      when peek(*LEFT) then LEFT
      when peek(*UP) then UP
      else DIAG
      end
    end
  end

  def self.lcs(a, b)
    walker = LCS.new(a, b)
    walker.backtrack.map { |i| a[i] }.join
  end

  def self.longest_common_substring(a, b)
    lengths = Array.new(a.length) { Array.new(b.length, 0) }
    greatestLength = 0
    output = ""
    a.each_char.with_index do |x, i|
      b.each_char.with_index do |y, j|
        next if x != y
        lengths[i][j] = (i.zero? || j.zero?) ? 1 : lengths[i - 1][j - 1] + 1
        if lengths[i][j] > greatestLength
          greatestLength = lengths[i][j]
          output = a[i - greatestLength + 1, greatestLength]
        end
      end
    end
    output
  end

  def self.distance(a, b)
    a, b = a.downcase, b.downcase
    costs = Array(0..b.length) # i == 0
    (1..a.length).each do |i|
      costs[0], nw = i, i - 1 # j == 0; nw is lev(i-1, j)
      (1..b.length).each do |j|
        costs[j], nw = [costs[j] + 1, costs[j - 1] + 1, a[i - 1] == b[j - 1] ? nw : nw + 1].min, costs[j]
      end
    end
    costs[b.length]
  end

end

class SearchController < ApplicationController

  def index
    @query = " #{params[:q].downcase} "

    data = [
      *@current_user.works,
      *@current_user.submissions,
      *@current_user.buyers,
      *@current_user.licenses,
      *@current_user.contracts
    ]
    data = data.map do |record|
      s = " #{record.class.name} #{record.to_json} #{record.short_description} ".downcase
      {
        record: record,
        string: s,
        lcs: StringMetrics.lcs(@query, s).size,
        levenshtein: StringMetrics.distance(@query, s),
        longest_common_substring: StringMetrics.longest_common_substring(@query, s).size,
      }
    end
    data = data.sort do |a, b|
      a_score = a[:longest_common_substring] + a[:lcs]
      b_score = b[:longest_common_substring] + b[:lcs]
      if a_score == b_score
        a[:levenshtein] <=> b[:levenshtein]
      else
        b_score <=> a_score
      end
    end
    @data = data.take(100)
  end
end
