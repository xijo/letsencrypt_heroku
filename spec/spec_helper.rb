$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'letsencrypt_heroku'

require 'fileutils'
FileUtils.rm('log/letsencrypt_heroku.log')
