# frozen_string_literal: true

module LoggingLibrary
  #
  # Module responsible for instantiating logger objects.
  #
  module LoggerFactory
    module_function

    # Creates a new `Logger` object.
    #
    # @param name [String] Optional name of the logger. If not provided, a
    #                      default will be determined from backtrace.
    #
    # @return [Logger]
    def create(name = nil)
      logger_name = name || caller(1..1).first[/`(.+)'/, 1]
      Logger.new(logger_name)
    end
  end
end
