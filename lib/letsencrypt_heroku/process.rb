module LetsencryptHeroku
  class Process
    attr_accessor :context

    def initialize(config)
      @context = OpenStruct.new(config: config)
    end

    def perform
      [PrepareConfig, CheckPreconditions, SetupClient, AuthorizeDomains, UpdateCertificates].each do |klass|
        klass.new.perform(context)
      end
    end
  end
end
