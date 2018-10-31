# frozen_string_literal: true

# reek.
module ArgumentChecker
  def check_argument(argument_name, expected_class, value)
    return if value.is_a?(expected_class)
    raise_argument_error(argument_name, expected_class, value.class)
  end

  def raise_argument_error(argument_name, expected_class, given_class)
    message = "Expecting `#{argument_name}` to be an instance of " \
              "`#{expected_class}`, #{given_class} given"

    raise ArgumentError, message
  end
end