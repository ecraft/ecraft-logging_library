#!/usr/bin/env ruby

require 'ecraft/logging_library'

class SomeClass
  include Ecraft::LoggingLibrary::Loggable

  def initialize
    logger.level = :debug
  end

  def colortest
    logger.fatal('This is a fatal error')
    logger.error('This is a non-fatal error')
    logger.warn('This is a warning. No need to panic.')
    logger.info('This is just regular info.')
    logger.debug('This is a debug message that most applications will have disabled.')
  end
end

SomeClass.new.colortest
