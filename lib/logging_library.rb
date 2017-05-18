require 'logging_library/custom_formatter'
require 'logging_library/logger_factory'
require 'logging_library/logger'
require 'logging_library/mixins/loggable'
require 'logging_library/version'

module LoggingLibrary
  Loggable = Mixins::Loggable
end
