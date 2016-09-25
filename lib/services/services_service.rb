require_relative '../utils/array'

class ServicesService < Inflect::AbstractService
  using ::Utils::ArrayMethods

  def initialize
    @priority = 1
    @words   = %W[PALABRAS CLAVE]
  end

  def default
    respond words: all_words.clip
  end

  def clave
    respond words: key_words.clip
  end

  private

  def all_words
    services.collect { |service| service.words }.flatten
  end

  def key_words
    services.collect { |service| service.words.first }.flatten
  end
end