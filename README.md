# LetsencryptHeroku

CLI tool to automate SSL certificate setup and renewal for **letsencrypt** and **rails** (or any other rack based application).

## Procedure

To grant a SSL certificate for a given domain, letsencrypt requires a challenge
request to be correctly answered on this domain. To automate this process this gem will perform the following steps for you:

1. Register the domain and a contact email with letsencrypt
1. Letsencrypt provides the expected challenge request answer
1. Make your application answer correctly
1. Trigger letsencrypt challenge process
1. Download issued certificates from letsencrypt
1. Setup certificates for your heroku application

## Installation

### In a nutshell

1. Install [the gems](#the-gems)
2. Deploy your application
3. Write [configuration file](#configuration)
4. Run `letsencrypt_heroku`
5. [Verify SSL is working correctly](#verify-ssl-is-working-correctly)

### The gems

```ruby
gem 'letsencrypt_rack'
gem 'letsencrypt_heroku', require: false
```

#### Wait, why do I need two gems?

To perform SSL certificate setup and renewal a command line tool is used: `letsencrypt_heroku`. This tool will only be needed on your development machine and does not need to be loaded into your production environment.

`letsencrypt_rack` contains a tiny rack middleware, that answers challenge request at the following path: `/.well-known/acme-challenge`. It serves the contents of the `LETSENCRYPT_RESPONSE` environment variable.


### Configuration

Put a configuration file under `config/letsencrypt_heroku.yml` that looks like this:

```yml
- contact:    email@example.dev
  domains:    example.dev www.example.dev
  heroku_app: example-dev-application
```

Each block in this configuration will issue a new certificate, so if you need to retrieve more than one (e.g. for another environment) you can configure more:

```yml
- contact:    email@example.dev
  domains:    example.dev www.example.dev
  heroku_app: example-dev-application

- contact:    email@example.dev
  domains:    stg.example.dev
  heroku_app: stg-example-dev-application
```

Please note that your application will be restarted for every single domain in your config. The restart happens automatically when the heroku challenge response gets set as environment variable.


### Verify SSL is working correctly

If `curl -vI https://www.example.dev` outputs this line everything is fine: `SSL certificate verify ok`.

You might also want to check the results of [ssltest](https://www.ssllabs.com/ssltest) every now and then to find out if you're vulnerable to any attack vector.


## Useful links and information

* https://www.ssllabs.com/ssltest
* https://devcenter.heroku.com/articles/ssl
* https://letsencrypt.org/
* https://github.com/eliotsykes/rails-security-checklist


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/xijo/letsencrypt_heroku.


## TODO

- document extraordinary configuration options (multiple domain SSL on single application)
- configurable config file location
