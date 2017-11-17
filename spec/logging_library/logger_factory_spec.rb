module LoggingLibrary
  describe LoggerFactory do
    it 'takes optional explicit name' do
      logger = LoggerFactory.create('the-name')
      expect(logger.name).to eq 'the-name'
    end

    it 'calculates a default name from backtrace' do
      logger = LoggerFactory.create

      expect(logger.name).to match(/LoggingLibrary/)
    end
  end
end
