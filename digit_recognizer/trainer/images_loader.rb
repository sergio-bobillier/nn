# frozen_string_literal: true

require_relative 'loader'
require_relative 'exceptions/invalid_images_file_error.rb'

class ImagesLoader < Loader
  EXPECTED_HEADER = "\x00\x00\x08\x03"
  READ_EXCEPTION = InvalidImagesFileError

  def load_onto(index)
    super

    rows = fetch_dimension('rows')
    cols = fetch_dimension('columns')
    image_size = rows * cols
    entries_read = 0
    bytes_read = 0

    until @file.eof? || entries_read == max_entries
      chunk = @file.read(image_size)

      unless chunk.size == image_size
        raise_read_error READ_EXCEPTION, "Corrupt chunk at byte #{bytes_read}"
      end

      index[entries_read][:image] = chunk.bytes

      bytes_read += image_size
      entries_read += 1
    end

    @file.close
  end

  def fetch_dimension(name)
    dimension = @file.read(4).unpack1('N')
    return dimension if dimension.is_a?(Integer) && dimension.positive?

    raise_read_error READ_EXCEPTION, "invalid number of #{name}: #{dimension}"
  end
end
