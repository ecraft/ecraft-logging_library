module LoggingLibrary
  module Mixins
    #
    # Mixin for adding a lazily-instantiated `logger` attribute to your class, with reasonable defaults based on the class name.
    #
    module Loggable
      def logger
        @logger ||= LoggerFactory.create(_logger_name)
      end

      private

      def _logger_name
        # Handle both `extend` and `include` use cases.
        if self.class == Class
          _short_class_name(to_s)
        else
          _short_class_name(self.class.name)
        end
      end

      def _short_class_name(full_name)
        # ClassThatIncludesLoggable vs Ecraft::LoggingLibrary::ClassThatIncludesLoggable. The latter feels overly detailed;
        # there are hopefully not that many classes with the same name in an application...
        full_name.split('::').last
      end
    end
  end
end
