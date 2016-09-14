class UnclearService < Inflect::AbstractService
  # A WORDS Array constant with the key words of the Service.
  # @example Array for New York Times service
  #   words = %W[ NEWS TODAY NEW\ YORK\ TIMES]

  # In case there are modules that provide similar contents the
  # one with most PRIORITY is picked.
  # Float::Infinity is set so it will always be the last service
  # in the array.
  def initialize
    @priority = Float::INFINITY
    @words   = %W[DESCONOCIDO]
  end

  # Overwrite #valid? method to be always valid
  # in case of being the last Service
  def valid?(words)
    true
  end

  # Returns a Response Object with the key
  def default
    respond "No se encontró ningún servicio que responda a #{words.first.downcase}", {type: 'simple', status: 'not_found'}
  end
end
