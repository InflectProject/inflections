class ServicesService < Inflect::AbstractService
  def initialize
    @priority = 1
    @words   = %W[PALABRAS CLAVE]
  end

  def default
    respond words: all_words
  end

  def clave
    respond words: key_words
  end

  private

  def all_words
    services.collect { |service| service.words }.flatten
  end

  def key_words
    services.collect { |service| service.words.first }.flatten
  end
end