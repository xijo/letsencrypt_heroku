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
require 'letsencrypt_heroku/process/setup_client'
require 'letsencrypt_heroku/process/authorize_domains'
require 'letsencrypt_heroku/process/update_certificates'

module LetsencryptHeroku
  class CLI
    CONFIG_FILE = 'config/letsencrypt_heroku.yml'

    def self.run(opts)
      entries = read_config_file(opts[:config])
      entries = limit_entries(entries, opts[:limit])
      entries.each { |entry| Process.new(entry).perform }
    end

    def self.limit_entries(entries, limit)
      return entries if limit.nil?
      puts "Restrict to domains including: #{Rainbow(limit).yellow}"
      entries.select { |c| c.domains.include?(limit) }
    end

    def self.read_config_file(file)
      if File.exist?(file)
        Array(YAML.load(File.read(file))).map { |c| OpenStruct.new(c) }
      else
        abort "Config file not found: #{Rainbow(file).red}"
      end
    end
  end

  class TaskError < StandardError
  end
end
