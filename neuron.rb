# frozen_string_literal: true

require 'forwardable'

require_relative 'argument_checker'

# Models a Neuron in the network
class Neuron
  extend Forwardable

  include ArgumentChecker

  attr_reader :value, :bias

  def initialize(value = 0.0, bias = nil)
    self.value = value
    self.bias = bias

    @connections = []
  end

  def connections
    @connections.dup
  end

  def value=(value)
    check_argument(name: 'value', expected_class: Float, value: value)
    @value = value
  end

  def_delegators :@connections, :<<

  def feed
    value = @connections.reduce(0) do |accumulated_value, connection|
      accumulated_value + connection.weight * connection.source.value
    end

    @value = sigmoid(value - @bias)
  end

  private

  def bias=(bias)
    case bias
    when NilClass
      @bias = rand
    when Float
      @bias = bias
    else
      raise_argument_error('bias', Float, bias.class)
    end
  end

  def sigmoid(value)
    1 / (1 + Math.exp(-value))
  end
end
