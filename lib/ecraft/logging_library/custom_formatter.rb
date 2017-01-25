require 'logger'
require 'rainbow'

module Ecraft
  module LoggingLibrary
    #
    # Handles log formatting. Not intended to be used from user code.
    #
    class CustomFormatter < ::Logger::Formatter
      DATE_PATTERN = '%Y-%m-%d %H:%M:%S.%L'.freeze

      def call(severity, time, progname, message)
        # LOG_PATTERN = '%l [%d] %c: %M'.freeze

        result = if show_time?
          format("%-5s [%s] %s: %s\n", severity, time.strftime(DATE_PATTERN), progname, message_to_s(message))
        else
          format("%-5s %s: %s\n", severity, progname, message_to_s(message))
        end

        if tty?
          Rainbow(result).color(color_for_severity(severity))
        else
          result
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

      # @param severity [String] The severity, like INFO, ERROR etc.
      def color_for_severity(severity)
        case severity.downcase.to_sym
        when :fatal then :red
        when :error then '#FF4040'
        when :warn  then :yellow
        when :info  then '#FFFFFF'
        when :debug then :gray
        else :gray
        end
      end

      def show_time?
        # When STDOUT is redirected, we are likely running as a service with a syslog daemon already appending a timestamp to the
        # line (and two timestamps is redundant).
        tty?
      end

      def tty?
        STDOUT.tty?
      end
    end
  end
end
