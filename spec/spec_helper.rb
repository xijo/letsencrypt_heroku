$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'letsencrypt_heroku'

require 'fileutils'
require 'pathname'

log_path = 'log/letsencrypt_heroku.log'
FileUtils.rm(log_path) if Pathname.new(log_path).exist?
