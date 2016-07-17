require 'rainbow'
require 'tty-spinner'
require 'yaml'
require 'acme-client'
require 'openssl'
require 'letsencrypt_heroku/version'
require 'letsencrypt_heroku/setup'

module LetsencryptHeroku
  class CLI
    CONFIG_FILE = 'config/letsencrypt_heroku.yml'

    def self.run
      if File.exist?(CONFIG_FILE)
        configs = Array(YAML.load(File.read(CONFIG_FILE))).map { |c| OpenStruct.new(c) }
        configs.each { |config| Setup.new(config).perform }
      else
        puts Rainbow("Missing config: #{CONFIG_FILE}").red
      end
    end
  end
end
