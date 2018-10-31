# frozen_string_literal: true

require_relative 'digit_recognizer'

dr = DigitRecognizer.new(784)

data = File.read('data').lines.map { |l| l.chomp.chars.map(&:to_f) }.flatten
dr.feed(data)
dr.classify

puts dr.output_layer.neurons.map { |n| n.value }
