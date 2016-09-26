require 'net/http'

class HolidayService < Inflect::AbstractService
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

    content  = { 'title': @title, 'body': body }

    respond content
  end

  def proximos
    response = Net::HTTP.get(@base_url, '/API/v1/actual')
    body = JSON.parse(response)

    days = filter_days(filter_months body)
    content = { days: days.first(5) }

    respond  content, {type: 'list'}
  end

  private

  def filter_months(days)
    today = Date.today
    days.find_all { |day| day["mes"] >= today.month }
  end

  def filter_days(days)
    today = Date.today
    days.reject { |day| day["mes"].eql? today.month && day["dia"] < today.day }
  end
end
