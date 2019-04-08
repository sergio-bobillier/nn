# frozen_string_literal: true

require_relative 'labels_loader'
require_relative 'images_loader'

# Holds an index of handwritten digits with its corresponding labels
class Index
  attr_reader :index_file, :images_file, :max_entries

  def initialize(index_file, images_file, max_entries = nil)
    @index_file = index_file
    @images_file = images_file
    @max_entries = max_entries
  end

  def build
    @index = []
    LabelsLoader.new(index_file, max_entries).load_onto(@index)
    ImagesLoader.new(images_file, max_entries).load_onto(@index)
    @index
  end
end
