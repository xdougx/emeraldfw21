require 'zip'

module EmeraldFW

  class Entity

    attr_accessor :entity_type, :valid_commands

    def initialize(args,opts)
      @args = args
      @opts = opts
    end

    def is_valid_command?
      valid_commands.include?(@command)
    end

    def json_contents(json_file_name)
      JSON.load(File.read(json_file_name))
    end

    def json_write(json_file_name,json)
      File.open(json_file_name,"w") do |f| 
        f.write(JSON.pretty_generate(json))
      end 
    end

    def execute_command
      @command = @args[1].to_sym
      EmeraldFW.exit_error(102,@valid_commands) if not is_valid_command?
      method(@command).call
    end

  end

end