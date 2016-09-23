class LetsencryptHeroku::Process
  class UpdateCertificates
    include LetsencryptHeroku::Tools

    def perform(context)
      herokuapp = context.config.heroku_certificate_app

      output 'Update certificates' do
        csr = Acme::Client::CertificateRequest.new(names: context.config.domains)
        certificate = context.client.new_certificate(csr)
        File.write('privkey.pem', certificate.request.private_key.to_pem)
        File.write('fullchain.pem', certificate.fullchain_to_pem)

        if has_already_cert(herokuapp)
          execute "heroku certs:update fullchain.pem privkey.pem --confirm #{herokuapp} --app #{herokuapp}"
        else
          execute "heroku certs:add fullchain.pem privkey.pem --app #{herokuapp}"
        end
        FileUtils.rm %w(privkey.pem fullchain.pem)
      end
      puts # finish the output with a nice newline ;)
    end

    def has_already_cert(herokuapp)
      Open3.popen3("heroku certs:info --app #{herokuapp}") do |stdin, stdout, stderr, wait_thr|
        return wait_thr.value.success?
      end
    end
  end
end
