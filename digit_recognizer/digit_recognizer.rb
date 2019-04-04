# frozen_string_literal: true

require_relative '../neural_network'

# A multi-layer perceptron to recognize hand-written digits
class DigitRecognizer < NeuralNetwork
  include ArgumentChecker

  def initialize(input_layer_size)
    check_argument('input_layer_size', Integer, input_layer_size)

    network_settings = NetworkSettings.new.tap do |settings|
      settings.input_layer_size = input_layer_size
      settings.hidden_layers = 2
      settings.hidden_layers_size = 16
      settings.output_layer_size = 10
    end

    super(network_settings)
  end
end
