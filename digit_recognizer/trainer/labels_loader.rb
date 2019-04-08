# frozen_string_literal: true

require_relative 'loader'
require_relative 'exceptions/invalid_index_file_error.rb'

# Loads the labels file and add them to the index
class LabelsLoader < Loader
  EXPECTED_HEADER = "\x00\x00\x08\x01"
  READ_EXCEPTION = InvalidIndexFileError

  def load_onto(index)
    super

    entries_read = 0

    until @file.eof? || entries_read == max_entries
      number = @file.read(1).ord
      index << { number: number }
      entries_read += 1
    end

    @file.close
  end
end
