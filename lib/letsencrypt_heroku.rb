require 'rainbow'
require 'tty-spinner'
require 'yaml'
require 'acme-client'
require 'openssl'
require 'logger'
require 'ostruct'
require 'open3'
require 'letsencrypt_heroku/version'
require 'letsencrypt_heroku/tools'
require 'letsencrypt_heroku/process'
require 'letsencrypt_heroku/config_builder'
require 'letsencrypt_heroku/process/prepare_config'
require 'letsencrypt_heroku/process/check_preconditions'
require 'letsencrypt_heroku/process/setup_client'
require 'letsencrypt_heroku/process/authorize_domains'
require 'letsencrypt_heroku/process/update_certificates'

module LetsencryptHeroku
  class CLI
    CONFIG_FILE = 'config/letsencrypt_heroku.yml'

    # generate config?

    # limit to domain, skip other configs

    def self.run
      if File.exist?(CONFIG_FILE)
        configs = Array(YAML.load(File.read(CONFIG_FILE))).map { |c| OpenStruct.new(c) }
        configs.each { |config| Process.new(config).perform }
      else
        puts Rainbow("Missing config: #{CONFIG_FILE}").red
      end
    end
  end

  class TaskError < StandardError
  end
end
