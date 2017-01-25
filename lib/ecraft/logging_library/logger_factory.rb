module Ecraft
  module LoggingLibrary
    #
    # Module responsible for instantiating logger objects.
    #
    module LoggerFactory
      module_function

      # Creates a new `Logger` object.
      #
      # @param name [String] An optional parameter for overriding the name of the logger. If not provided, a default will be
      #   determined automatically.
      def create(name = nil)
        logger_name = name || caller[0][/`.*'/][1..-2]
        Logger.new(logger_name)
      end
    end
  end
end
