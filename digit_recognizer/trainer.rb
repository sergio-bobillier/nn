# frozen_string_literal: true

require_relative '../argument_checker'
require_relative 'trainer/index'

require 'byebug'

class Trainer
  include ArgumentChecker

  attr_reader :index_file, :images_file, :max_images

  def initialize(index_file, images_file, max_images = nil)
    check_argument(name: 'index_file', expected_class: String, value: index_file)
    check_argument(name: 'images_file', expected_class: String, value: images_file)
    check_argument(name: 'max_images', expected_class: Integer, value: max_images, allow_nil: true)

    @index_file = index_file
    @images_file = images_file
    @max_images = max_images

    @index = Index.new(index_file, images_file, max_images).build
  end
end
