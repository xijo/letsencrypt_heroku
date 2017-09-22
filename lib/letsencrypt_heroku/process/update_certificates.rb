class LetsencryptHeroku::Process
  class UpdateCertificates
    include LetsencryptHeroku::Tools

    def perform(context)
      herokuapp = context.config.heroku_certificate_app

      output 'Update certificates' do
        csr = Acme::Client::CertificateRequest.new(names: context.config.domains)
        certificate = context.client.new_certificate(csr)
        privkey_name = "privkey_#{herokuapp}.pem"
        fullchain_name = "fullchain_#{herokuapp}.pem"
        File.write(privkey_name, certificate.request.private_key.to_pem)
        File.write(fullchain_name, certificate.fullchain_to_pem)

        if has_already_cert(herokuapp)
          execute "heroku certs:update #{fullchain_name} #{privkey_name} --confirm #{herokuapp} --app #{herokuapp}"
        else
          execute "heroku certs:add #{fullchain_name} #{privkey_name} --app #{herokuapp}"
        end

        unless context.config.keep_certs
          FileUtils.rm [privkey_name, fullchain_name]
        end
      end
      puts # finish the output with a nice newline ;)
    end

    def has_already_cert(herokuapp)
      execute("heroku certs:info --app #{herokuapp}") do |stdin, stdout, stderr, wait_thr|
        return wait_thr.value.success?
      end
    end
  end
end
