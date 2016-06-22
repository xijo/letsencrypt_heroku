# LetsencryptHeroku

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/letsencrypt_heroku`. To experiment with that code, run `bin/console` for an interactive prompt.

## Installation

Add these lines to your application's Gemfile:

```ruby
gem 'letsencrypt_rack'
gem 'letsencrypt_heroku', require: false
```

And then execute:

    $ bundle

You'll need a `config/letsencrypt_heroku.yml`

    - contact:    contact@foobar.dev
      domains:    foobar.dev www.foobar.dev
      herokuapp:  foobar

And finally execute

    $ letsencrypt_heroku

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/xijo/letsencrypt_heroku.

