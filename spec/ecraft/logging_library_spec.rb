require 'spec_helper'
require 'ecraft/logging_library' # Not included by default

describe Ecraft::LoggingLibrary do
  it 'is defined as a compatibility module' do
    expect(subject).to eq LoggingLibrary
  end
end
