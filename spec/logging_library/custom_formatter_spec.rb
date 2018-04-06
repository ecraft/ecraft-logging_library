# frozen_string_literal: true

module LoggingLibrary
  describe CustomFormatter::LogMessage do
    describe '#to_formatted_string' do
      context 'when message is a Hash' do
        before {
          subject.message = { foo: 'bar' }
        }

        it 'returns the expected result' do
          result = subject.send(:formatted_message)
          expect(result).to eq '{:foo=>"bar"}'
        end
      end
    end
  end
end
