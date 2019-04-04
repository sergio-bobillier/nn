# frozen_string_literal: true

require_relative 'argument_checker'
require_relative 'layer'
require_relative 'network_settings'

# Base class for all neural networks
class NeuralNetwork
  include ArgumentChecker

  attr_reader :input_layer
  attr_reader :output_layer

  def initialize(network_settings)
    check_argument(name: 'network_settings', expected_class: NetworkSettings, value: network_settings)

    @input_layer = Layer.new(network_settings.input_layer_size)

    @hidden_layers = []

    network_settings.hidden_layers.times do
      @hidden_layers << Layer.new(network_settings.hidden_layers_size)
    end

    @output_layer = Layer.new(network_settings.output_layer_size)

    connect_network
  end

  def connect_network
    source = @input_layer

    @hidden_layers.each do |hidden_layer|
      source.connect_to(hidden_layer)
      source = hidden_layer
    end

    source.connect_to(@output_layer)
  end

  def feed(data)
    check_argument(name: 'data', expected_class: Array, value: data)

    data.each_with_index do |datum, index|
      @input_layer[index].value = datum
    end
  end

  def classify
    @hidden_layers.each(&:feed)
    @output_layer.feed
  end
end
