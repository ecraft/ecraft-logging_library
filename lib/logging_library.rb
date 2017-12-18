require 'logging_library/custom_formatter'
require 'logging_library/logger_factory'
require 'logging_library/logger'
require 'logging_library/mixins/loggable'
require 'logging_library/version'

module LoggingLibrary
  Loggable = Mixins::Loggable

  LOG_LEVELS = Mixlib::Log::LEVELS.keys.freeze

  class << self
    def output_device
      @output_device ||= $stderr
    end

    attr_writer :output_device
  end
end

# Avoid buffering output when running under e.g. Foreman.
$stdout.sync = true
$stderr.sync = true
