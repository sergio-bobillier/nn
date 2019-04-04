# frozen_string_literal: true

require_relative 'argument_checker'

# Models a connections between Neurons
class Connection
  include ArgumentChecker

  attr_reader :source, :target, :weight

  def initialize(source, target, weight = nil)
    self.source = source
    self.target = target
    self.weight = weight
  end

  def weight=(weight)
    case weight
    when NilClass
      @weight = rand
    when Float
      @weight = weight
    else
      raise_argument_error('weight', Float, weight.class)
    end
  end

  private

  def source=(source)
    check_neuron_argument(source, 'source')
    @source = source
  end

  def target=(target)
    check_neuron_argument(target, 'target')
    @target = target
  end

  def check_neuron_argument(neuron, name)
    check_argument(name: name, expected_class: Neuron, value: neuron)
  end
end
