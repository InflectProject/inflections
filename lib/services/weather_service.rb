class WeatherService < Inflect::AbstractService
  require 'forecast_io'

  # A WORDS Array constant with the key words of the Service.

  # In case there are modules that provide similar contents the
  # one with most PRIORITY is picked.
  # Float::Infinity is the lowest priority.
  def initialize
    @priority = 2
    @words    = %W[CLIMA]
    @title    = 'Clima'
  end

  # Returns:
  # 'currently': A data block (see below) containing the current weather conditions at the requested location.
  # 'hourly': A data block (see below) containing the weather conditions hour-by-hour for the next two days.
  # 'daily': A data block (see below) containing the weather conditions day-by-day for the next week.
  # Data block:
  # summary: A human-readable text summary of this data block.
  # icon: A machine-readable text summary of this data block (see data point, above, for an enumeration of possible values that this property may take on).
  # data: An array of data point objects (see https://developer.forecast.io/docs/v2?#data-points), ordered by time, which together describe the weather conditions at the requested location over time.
  def default
    ForecastIO.configure do |configuration|
      configuration.api_key = '7780ee7ace4bd1e611a540ea548373a5'
      configuration.default_params = {
        units: 'auto',
        exclude: ['flags','minutely'],
        lang:['es']
      }
    end

    # units: auto ; selects units automatically, based on geographic location
    forecast = ForecastIO.forecast(-34.9314, -57.9489)

    # usage example. forecast.hourly.summary ; forecast.daily.summary
    forecastSummary = {
      currently: forecast.currently.summary,
      hourly: forecast.hourly.summary,
      daily: forecast.daily
    }

    content  = { title: 'Clima', body: forecastSummary }
    respond content, { type: 'list' }
  end
end
