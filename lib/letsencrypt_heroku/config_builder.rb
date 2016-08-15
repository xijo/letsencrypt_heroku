class LetsencryptHeroku::ConfigBuilder
  include LetsencryptHeroku::Tools

  # Create a letsencrypt_heroku config file under the given path.
  #
  def perform(path = 'config/letsencrypt_heroku.yml')
    banner 'Generate:', "#{Dir.pwd}/#{path}"

    output("write file") do
      error('already exists') if File.exists?(path)

    end
  end
end
