module Ecraft
  module LoggingLibrary
    #
    # Module responsible for instantiating logger objects. This module is not intended to be used from user code.
    #
    module LoggerFactory
      module_function

      def create(name = nil)
        logger_name = name || caller[0][/`.*'/][1..-2]
        Logger.new(logger_name)
      end

      def _create_formatter
        Log4r::PatternFormatter.new(
          pattern: LOG_PATTERN,
          date_pattern: DATE_PATTERN
        )
      end
    end
  end
end
