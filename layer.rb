# frozen_string_literal: true

require 'forwardable'

require_relative 'argument_checker'
require_relative 'connection'
require_relative 'neuron'

# Models a Neuron layer
class Layer
  extend Forwardable

  include ArgumentChecker

  def initialize(size = 0)
    check_argument('size', Integer, size)
    raise ArgumentError, '`size` should be greater than 0' unless size.positive?

    @neurons = []
    size.times { @neurons << Neuron.new }
  end

  def neurons
    @neurons.dup
  end

  def <<(neuron)
    check_argument('neuron', Neuron, neuron)
    @neurons << neuron
  end

  alias push <<
  alias add <<

  def_delegators :@neurons, :[], :delete, :each

  def connect_to(layer)
    layer.each do |neuron|
      create_connections_to(neuron)
    end
  end

  def feed
    @neurons.each(&:feed)
  end

  private

  def create_connections_to(target_neuron)
    @neurons.each do |neuron|
      target_neuron << Connection.new(neuron, target_neuron)
    end
  end
end
