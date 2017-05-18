module LoggingLibrary
  describe CustomFormatter::LogMessage do
    describe '#formatted_message' do
      context 'when message is a Hash' do
        before {
          subject.message = { foo: 'bar' }
        }

        it 'returns the expected result' do
          result = subject.formatted_message
          expect(result).to eq '{:foo=>"bar"}'
        end
      end
    end
  end
end
