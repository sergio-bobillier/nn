# frozen_string_literal: true

require_relative 'argument_checker'

# A set of settings for a neural network
class NetworkSettings
  include ArgumentChecker

  attr_reader :input_layer_size
  attr_reader :hidden_layers
  attr_reader :hidden_layers_size
  attr_reader :output_layer_size

  def input_layer_size=(input_layer_size)
    check_integer_argument('input_layer_size', input_layer_size)
    check_positive_value('input_layer_size', input_layer_size)
    @input_layer_size = input_layer_size
  end

  def hidden_layers=(hidden_layers)
    check_integer_argument('hidden_layers', hidden_layers)
    check_positive_value('hidden_layers', hidden_layers)
    @hidden_layers = hidden_layers
  end

  def hidden_layers_size=(hidden_layers_size)
    check_integer_argument('hidden_layers_size', hidden_layers_size)
    check_positive_value('hidden_layers_size', hidden_layers_size)
    @hidden_layers_size = hidden_layers_size
  end

  def output_layer_size=(output_layer_size)
    check_integer_argument('output_layer_size', output_layer_size)
    check_positive_value('output_layer_size', output_layer_size)
    @output_layer_size = output_layer_size
  end

  private

  def check_integer_argument(attribute_name, value)
    check_argument(name: attribute_name, expected_class: Integer, value: value)
  end

  def check_positive_value(attribute_name, value)
    return if value.positive?

    raise ArgumentError, "`#{attribute_name}` must be greater than 0"
  end
end
