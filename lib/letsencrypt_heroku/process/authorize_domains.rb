class LetsencryptHeroku::Process
  class AuthorizeDomains
    include LetsencryptHeroku::Tools

    def perform(context)
      context.config.domains.each do |domain|
        output "Authorize #{domain}" do
          authorize(domain: domain, context: context)
        end
      end
    end

    def authorize(domain:, context:)
      challenge = context.client.authorize(domain: domain).http01

      execute "heroku config:set LETSENCRYPT_RESPONSE=#{challenge.file_content} --app #{context.config.heroku_challenge_app}"

      test_response(domain: domain, challenge: challenge)

      challenge.request_verification
      sleep(1) while 'pending' == challenge.verify_status
      challenge.verify_status == 'valid' or error('failed authorization')
    end

    def test_response(domain:, challenge:)
      url        = "http://#{domain}/#{challenge.filename}"
      fail_count = 0
      answer     = nil

      while answer != challenge.file_content
        error('failed test response') if fail_count > 30
        fail_count += 1
        sleep(1)
        answer = `curl -sL #{url}`
      end
    end
  end
end
