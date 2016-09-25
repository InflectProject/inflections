require_relative '../utils/hash'

class UnclearService < Inflect::AbstractService
  using ::Utils::HashMethods

  attr_accessor :answers

  def initialize
    @priority = Float::INFINITY
    @words   = %W[DESCONOCIDO]
    @answers = [
      { text: 'No te entendí, podrías repetirme?', allows_suggestion: false}, 
      { text: 'No se cómo responder a eso :(', allows_suggestion: true } ,
      { text: 'No me enseñaron a responder eso aún', allows_suggestion: true }
    ]
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

  def suggestions
    Inflect.handle(['PALABRAS', 'CLAVE']).content[:words]
  end

  def random_suggestion
    suggestions[rand(suggestions.size)]
  end

  def random_answer
    answer = answers[rand(answers.size)].deep_dup
    answer[:text] << ", prueba diciendo '#{random_suggestion.downcase}'" if answer[:allows_suggestion]
    answer
  end
end
