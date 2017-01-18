require 'ecraft/logging_library/custom_formatter'
require 'ecraft/logging_library/logger_factory'
require 'ecraft/logging_library/logger'
require 'ecraft/logging_library/mixins/loggable'
require 'ecraft/logging_library/version'

module Ecraft
  module LoggingLibrary
    Loggable = Mixins::Loggable
  end
end
