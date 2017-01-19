module Ecraft
  module LoggingLibrary
    describe Loggable do
      context 'when a class includes the module' do
        before(:all) do
          ClassThatIncludesLoggable = Class.new {
            include Loggable
          }
        end
        let(:klass) { ClassThatIncludesLoggable }
        subject { klass.new }

        describe '#logger' do
          context 'responds to' do
            subject { klass.new.logger }

            it { is_expected.to respond_to :debug }
            it { is_expected.to respond_to :error }
            it { is_expected.to respond_to :info }
            it { is_expected.to respond_to :warn }
          end

          context do
            subject { klass.new }

            it 'reuses the same logger between calls' do
              expect(subject.logger).to be subject.logger
            end

            it 'sets the logger name to the expected value' do
              expect(subject.logger.name).to eq 'ClassThatIncludesLoggable'
            end
          end

          # DEBUG severity is not printed out by default.
          it "does not print a message to STDOUT when sending the 'debug' message" do
            expect { subject.logger.debug('debug blerp') }.to_not output.to_stdout
          end

          it "prints a message to STDOUT when sending the 'info' message" do
            expect { subject.logger.info('info blerp') }.to output(/info blerp/).to_stdout
          end

          it "prints a message to STDOUT when sending the 'warn' message" do
            expect { subject.logger.warn('warn blerp') }.to output(/warn blerp/).to_stdout
          end
        end
      end

      context 'when a class is extended with the module' do
        before(:all) do
          module Specs
            ClassThatExtendsLoggable = Class.new {
              extend Loggable
            }
          end
        end

        subject { Specs::ClassThatExtendsLoggable }

        describe '#logger_name' do
          it 'has the expected value' do
            expect(subject.logger.name).to eq 'ClassThatExtendsLoggable'
          end
        end
      end
    end
  end
end
