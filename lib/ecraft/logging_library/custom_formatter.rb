require 'logger'
require 'rainbow'

module Ecraft
  module LoggingLibrary
    #
    # Handles log formatting. Not intended to be used from user code.
    #
    class CustomFormatter < ::Logger::Formatter
      DATE_PATTERN = '%Y-%m-%d %H:%M:%S.%L'.freeze

      LogMessage = Struct.new(:severity, :time, :logger_name, :message) do
        LINE_PREPEND = ' ' * 8

        def to_formatted_string
          if show_time?
            format("%s %s %s %s\n", formatted_colored_severity, formatted_colored_time,
                   formatted_colored_logger_name, colored_message)
          else
            # No colorization is needed here, since we draw the assumption that if show_time? is false, we are being redirected.
            format("%-5s %s: %s\n", severity, logger_name, message_to_s(message))
          end
        end

        def colored_message
          return formatted_message unless tty?
          Rainbow(formatted_message).color(color_for_severity)
        end

        # Converts some argument to a Logger.severity() call to a string.  Regular strings pass through like
        # normal, Exceptions get formatted as "message (class)\nbacktrace", and other random stuff gets
        # put through "object.inspect"
        def formatted_message
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

        def formatted_colored_severity
          if tty?
            Rainbow(formatted_severity).color(color_for_severity)
          else
            formatted_severity
          end
        end

        def formatted_colored_time
          if tty?
            Rainbow(formatted_time).color(time_color_for_severity)
          else
            formatted_severity
          end
        end

        def formatted_colored_logger_name
          return formatted_logger_name unless tty?

          Rainbow(formatted_logger_name).color(color_for_severity)
        end

        def formatted_severity
          format('%-5s', severity)
        end

        def formatted_time
          '[' + time.strftime(DATE_PATTERN) + ']'
        end

        def formatted_logger_name
          logger_name + ':'
        end

        def color_for_severity
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
        def time_color_for_severity
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

      def call(severity, time, progname, message)
        LogMessage.new(severity, time, progname, message).to_formatted_string
      end
    end
  end
end
