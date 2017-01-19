require 'logger'

module Ecraft
  module LoggingLibrary
    #
    # Handles log formatting. Not intended to be used from user code.
    #
    class CustomFormatter < ::Logger::Formatter
      DATE_PATTERN = '%Y-%m-%d %H:%M:%S.%L'.freeze

      def call(severity, time, progname, message)
        # LOG_PATTERN = '%l [%d] %c: %M'.freeze

        if show_time?
          format("%-5s [%s] %s: %s\n", severity, time.strftime(DATE_PATTERN), progname, message_to_s(message))
        else
          format("%-5s %s: %s\n", severity, progname, message_to_s(message))
        end
      end

      private

      # Converts some argument to a Logger.severity() call to a string.  Regular strings pass through like
      # normal, Exceptions get formatted as "message (class)\nbacktrace", and other random stuff gets
      # put through "object.inspect"
      def message_to_s(message)
        case message
        when ::String
          message
        when ::Exception
          "#{message.message} (#{message.class})\n" <<
            (message.backtrace || []).join("\n")
        else
          msg.inspect
        end
      end

      def show_time?
        # When STDOUT is redirected, we are likely running as a service with a syslog daemon already appending a timestamp to the
        # line (and two timestamps is redundant).
        STDOUT.tty?
      end
    end
  end
end
