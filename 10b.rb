# frozen_string_literal: true

require "debug"

CORRUPT = ["(]", "(}", "(>", "{)", "{]", "{>", "[)", "[}", "[>", "<)", "<]", "<}"].freeze
POINTS  = { "(" => 1, "[" => 2, "{" => 3, "<" => 4 }.freeze

def clean(line)
  loop do
    line_before = line
    line = line.gsub(/(\(\)|\{\}|<>|\[\])/, "")

    break if line_before == line
  end

  line
end

def purify(line)
  CORRUPT.any? { |pair| line.include?(pair) } ? nil : line.reverse.chars
end

def score(line)
  line.inject(0) { |score, n| (score * 5) + POINTS[n] }
end

lines = File.read("10.input")
            .split
            .map(&method(:clean))
            .map(&method(:purify))
            .compact
            .map(&method(:score))
            .sort

puts lines[(lines.length / 2)] == 1_698_395_182
