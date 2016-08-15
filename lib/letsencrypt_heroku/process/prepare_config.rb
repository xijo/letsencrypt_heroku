class LetsencryptHeroku::Process
  class PrepareConfig
    include LetsencryptHeroku::Tools

    def perform(context)
      config = context.config
      config.domains = config.domains.to_s.split
      config.heroku_certificate_app ||= config.heroku_app
      config.heroku_challenge_app   ||= config.heroku_app

      validate_config(config)
      context
    end

    def validate_config(config)
      if config.domains.empty?
        error('Please provide `domains`')
      end

      unless config.heroku_certificate_app && config.heroku_challenge_app
        error('Please provide `heroku_app`')
      end
    end
  end
end
