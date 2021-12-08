file = 'input'

module Measurements
  class Slide
    def initialize(measurements)
      @measurements = measurements
    end

    def sum
      @measurements.sum
    end
  end

  def self.create_slides(measurements, window_size:)
    array = measurements.dup

    [].tap do |slides|
      while array.count >= window_size
        slides << Slide.new(array.take(3))
        array.shift
      end
    end
  end
end

measurements = File.read(file).split(/\r?\n/).map(&:to_i)

slides = Measurements.create_slides(measurements, window_size: 3)

previous = nil
puts(slides.select do |current|
  (previous && current.sum > previous.sum).tap { previous = current }
end.count)


