require 'spec_helper'

describe LetsencryptHeroku::Process::PrepareConfig do
  let(:prepare_config) { described_class.new }
  let(:context)        { OpenStruct.new(config: config) }
  let(:config)         { OpenStruct.new(domains: 'foo', heroku_app: 'bar') }

  describe '#perform' do
    it 'stores the heroku_app as challenge app' do
      config.heroku_app = 'foobar'
      prepare_config.perform(context)
      expect(config.heroku_challenge_app).to eq 'foobar'
    end

    it 'sets heroku_app as certificate app' do
      config.heroku_app = 'foobar'
      prepare_config.perform(context)
      expect(config.heroku_certificate_app).to eq 'foobar'
    end

    it 'leaves the certificate app if set' do
      config.heroku_app             = 'foobar'
      config.heroku_certificate_app = 'something'
      expect { prepare_config.perform(context) }.not_to change { config.heroku_certificate_app }
    end

    it 'leaves the challenge app if set' do
      config.heroku_app           = 'foobar'
      config.heroku_challenge_app = 'something'
      expect { prepare_config.perform(context) }.not_to change { config.heroku_challenge_app }
    end

    it 'splits given domains by space' do
      config.domains = 'hello.dev world.dev'
      prepare_config.perform(context)
      expect(config.domains).to eq ['hello.dev', 'world.dev']
    end

    it 'raises if no domains were set' do
      config.domains = nil
      expect { prepare_config.perform(context) }.to raise_error(LetsencryptHeroku::TaskError)
    end

    it 'raises if no heroku_app was set' do
      config.heroku_app = nil
      expect { prepare_config.perform(context) }.to raise_error(LetsencryptHeroku::TaskError)
    end
  end
end
