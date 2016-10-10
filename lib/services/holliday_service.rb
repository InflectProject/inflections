require 'net/http'

class HollidayService < Inflect::AbstractService
  # A WORDS Array constant with the key words of the Service.
  # @example Array for New York Times service
  #   words = %W[ NEWS TODAY NEW\ YORK\ TIMES]

  # In case there are modules that provide similar contents the
  # one with most PRIORITY is picked.
  # Float::Infinity is the lowest priority.
  def initialize
    @priority = 1
    @words    = %W[FERIADOS PROXIMOS]
    @title    = 'Proximo Feriado'
    @base_url  = 'nolaborables.com.ar'.freeze
  end

  # This is method is the only one needed for Inflect to work.
  # Implements how the service responds at the translated words.
  # Returns a Inflect::Response with retrieved data, .
  def default
    response = Net::HTTP.get(@base_url, '/API/v1/proximo')
    body     = JSON.parse(response)
    binding.pry
    content  = { 'title': @title, 'body': body }

    respond content
  end

  def proximos
    response = Net::HTTP.get(@base_url, '/API/v1/actual')
    body = JSON.parse(response)
    
    days = reject_past_dates body
    content = { body: days.first(5) }

    respond  content, {type: 'list'}
  end

  private
  def reject_past_dates(days)
    today = Date.today
    days.select { |day| Date.new(today.year, day["mes"], day["dia"]).between? today, Date.new(today.year, 12, 31) }
  end
end
