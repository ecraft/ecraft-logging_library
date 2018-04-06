# frozen_string_literal: true

require 'forwardable'
require 'mixlib/log'

module LoggingLibrary
  #
  # Responsible for printing out log messages. Not intended to be used
  # directly from user code; use the Loggable mixin (preferred) or
  # LoggerFactory (secondary choice) to create a logger.
  #
  class Logger
    include Mixlib::Log
    extend Forwardable

    def_delegator :logger, :progname, :name

    def initialize(name)
      init(LoggingLibrary.output_device)

      logger.level = :info
      logger.progname = name
      logger.formatter = CustomFormatter.new
    end
  end
end
