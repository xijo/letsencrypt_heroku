class LetsencryptHeroku::Process
  class CheckPreconditions
    include LetsencryptHeroku::Tools

    def perform(context)
      banner 'Running for:', context.config.domains.join(', ')
      output 'Prepare SSL endpoint' do
        execute "heroku labs:enable http-sni --app #{context.config.heroku_certificate_app}"
        execute 'heroku plugins:install heroku-certs'
      end
    end
  end
end


