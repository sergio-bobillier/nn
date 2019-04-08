# frozen_string_literal: true

# Error to be raised when the given images file is invalid (does not have the
# expected header or the expected data format)
class InvalidImagesFileError < StandardError
end
