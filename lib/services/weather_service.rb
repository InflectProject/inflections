class WeatherService < Inflect::AbstractService
  # A WORDS Array constant with the key words of the Service.
  # @example Array for New York Times service
  #   words = %W[ NEWS TODAY NEW\ YORK\ TIMES]

  # In case there are modules that provide similar contents the
  # one with most PRIORITY is picked.
  # Float::Infinity is the lowest priority.
  def initialize
    @priority = Float::INFINITY
    @words    = %W[WEATHER]
  end

  # This is method is the only one needed for Inflect to work.
  # Implements how the service responds at the translated words.
  # Returns a Inflect::Response with retrieved data.
  def handle(words)
    respond '35 °C'
  end
end
