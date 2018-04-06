# frozen_string_literal: true

require 'spec_helper'
require 'ecraft/logging_library' # Not included by default

describe Ecraft::LoggingLibrary do
  it 'is defined as a compatibility module' do
    expect(subject).to eq LoggingLibrary
  end

  it 'contains a Loggable constant' do
    expect { Ecraft::LoggingLibrary::Loggable }.to_not raise_error
  end
end
