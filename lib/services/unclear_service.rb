class UnclearService < Inflect::AbstractService
  attr_accessor :suggestions

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
    respond random_answer, {type: 'simple', status: 'not_found'}
  end

  private

  def answers
    [
      'No te entendí, podrías repetirme?', 
      'No se cómo responder a eso :(',
      'No me enseñaron a responder eso aún'
    ]
  end

  def suggestions
    service = services.find { |service| service.valid? ['PALABRAS'] }
    service.key_words
  end

  def random_service
    suggestions[rand(suggestions.size)]
  end

  def random_answer
    answers[rand(answers.size)]
  end
end
