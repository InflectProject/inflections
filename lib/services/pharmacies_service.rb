require 'nokogiri'
require 'open-uri'

class PharmaciesService < Inflect::AbstractService
  # A WORDS Array constant with the key words of the Service.
  # @example Array for New York Times service
  #   words = %W[ NEWS TODAY NEW\ YORK\ TIMES]

  # In case there are modules that provide similar contents the
  # one with most PRIORITY is picked.
  # Float::Infinity is the lowest priority.
  def initialize
    @priority = 1
    @words    = %W[FARMACIAS]
    @base_url = 'http://www.colfarmalp.org.ar/turnoslaplata.php'.freeze
    @title    = 'Farmacias de Turno'
  end

  # This is method is the only one needed for Inflect to work.
  # Implements how the service responds at the translated words.
  # Returns a Inflect::Response with retrieved data.
  def default
    pharmacies=[]
    doc = Nokogiri::HTML(open(@base_url))
    doc.css('.ver_tu table tr:not([style])').each do |tr|
      td=tr.css('td')[0..1]
      pharmacies << {
        name: td.first.content,
        address: td.last.content.encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
      }
    end
    content  = { title: @title, body: pharmacies }

    respond content, { type: 'list' }
  end
end
