class LetsencryptHeroku::Process
  class SetupClient
    include LetsencryptHeroku::Tools

    PRODUCTION = 'https://acme-v01.api.letsencrypt.org/'
    STAGING    = 'https://acme-staging.api.letsencrypt.org/'

    def perform(context)
      output 'Contact letsencrypt server' do
        context.client = build_client
        context.client.register(contact: "mailto:#{context.config.contact}").agree_terms or error('registration failed')
      end
    end

    def build_client
      Acme::Client.new(private_key: private_key, endpoint: PRODUCTION)
    end

    def private_key
      OpenSSL::PKey::RSA.new(4096)
    end
  end
end

