require 'logger'
require 'rainbow'

module Ecraft
  module LoggingLibrary
    #
    # Handles log formatting. Not intended to be used from user code.
    #
    class CustomFormatter < ::Logger::Formatter
      DATE_PATTERN = '%Y-%m-%d %H:%M:%S.%L'.freeze
      LINE_PREPEND = ' ' * 8

      def call(severity, time, progname, message)
        if show_time?
          format("%s %s %s %s\n", formatted_colored_severity(severity), formatted_colored_time(time, severity),
                 formatted_colored_progname(progname, severity), colored_message(message_to_s(message), severity))
        else
          # No colorization is needed here, since we draw the assumption that if show_time? is false, we are being redirected.
          format("%-5s %s: %s\n", severity, progname, message_to_s(message))
        end
      end

      private

      def formatted_colored_severity(severity)
        formatted_severity = format('%-5s', severity)

        if tty?
          Rainbow(formatted_severity).color(color_for_severity(severity))
        else
          formatted_severity
        end
      end

      def formatted_colored_time(time, severity)
        formatted_time = '[' + time.strftime(DATE_PATTERN) + ']'

        if tty?
          Rainbow(formatted_time).color(time_color_for_severity(severity))
        else
          formatted_severity
        end
      end

      def formatted_colored_progname(progname, severity)
        formatted_progname = progname + ':'
        return formatted_progname unless tty?

        Rainbow(formatted_progname).color(color_for_severity(severity))
      end

      def colored_message(mesage, severity)
        return message unless tty?
        Rainbow(mesage).color(color_for_severity(severity))
      end

      # Converts some argument to a Logger.severity() call to a string.  Regular strings pass through like
      # normal, Exceptions get formatted as "message (class)\nbacktrace", and other random stuff gets
      # put through "object.inspect"
      def message_to_s(message)
        case message
        when ::String
          message
        when ::Exception
          "#{message.message} (#{message.class})\n" +
            LINE_PREPEND +
            (message.backtrace || []).join("\n#{LINE_PREPEND}")
        else
          msg.inspect
        end
      end

      # @param severity [String] The severity, like INFO, ERROR etc.
      def color_for_severity(severity)
        case severity.downcase.to_sym
        when :fatal then :magenta
        when :error then :red
        when :warn  then :yellow
        when :info  then :gray
        when :debug then '#606060'
        else :gray
        end
      end

      # Returns a somewhat lighter color for the time, to make it stand out in the presentation.
      #
      # @param severity [String] The severity, like INFO, ERROR etc.
      def time_color_for_severity(severity)
        case severity.downcase.to_sym
        when :fatal then '#FF00FF'
        when :error then '#FF0000'
        when :warn  then '#FFFF00'
        when :info  then '#FFFFFF'
        when :debug then '#808080'
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
