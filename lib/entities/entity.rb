module EmeraldFW

  class Entity

    attr_accessor :entity_type, :valid_commands, :create, :remove

    def self.initialize(args,opts)
      @args = args
      @opts = opts
    end

    def execute
      @command = @args[1].to_sym
      EmeraldFW.exit_error(102,@valid_commands) if not @valid_commands.include?(@command)
      method(@command).call(@args,@opts)
      puts "Do something..."
    end

  end

end