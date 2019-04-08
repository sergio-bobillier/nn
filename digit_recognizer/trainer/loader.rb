# frozen_string_literal: true

class Loader
  attr_reader :data_file, :max_entries

  def initialize(data_file, max_entries)
    @data_file = data_file
    @max_entries = max_entries
  end

  def load_onto(_index)
    open_file_and_check_header
    entries_count = fetch_entires_count
    @max_entries = [entries_count, @max_entries].min
  end

  protected

  def open_file_and_check_header
    @file = File.open(data_file, 'rb')

    header = @file.read(4)
    return if header == self.class::EXPECTED_HEADER

    raise_read_error EXCEPTION, "invalid header: #{header}"
  end

  def fetch_entires_count
    count = @file.read(4).unpack1('N')
    return count if count.is_a?(Integer) && count.positive?

    raise_read_error EXCEPTION, "invalid entries count: #{count}"
  end

  def raise_read_error(error, message)
    @file.close
    raise error, message
  end
end
