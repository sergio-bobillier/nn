# frozen_string_literal: true

# reek.
module ArgumentChecker
  def check_argument(name:, expected_class:, value:, allow_nil: false)
    return if allow_nil && value.nil?
    return if value.is_a?(expected_class)

    raise_argument_error(name, expected_class, value.class)
  end

  def raise_argument_error(name, expected_class, given_class)
    message = "Expecting `#{name}` to be an instance of " \
              "`#{expected_class}`, #{given_class} given"

    raise ArgumentError, message
  end
end
