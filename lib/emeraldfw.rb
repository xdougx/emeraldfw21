require 'json'


module EmeraldFW


  @entities = [ :component, :email, :form, :library, :page, :project, :resource, :template ].sort

  def self.emeraldfw_init
    FileUtils.mkdir_p(EmeraldFW.emerald_projects_dir) if not File.exist?(EmeraldFW.emerald_projects_dir)
    config_file_generate if not File.exist?(EmeraldFW.emerald_config_file)
  end

  def self.start(args,opts)
    # Initializes the framework workspace if needed
    emeraldfw_init

    # Saves arguments and options
  	@arguments = args
    @options = opts

    # Isolates the entitle which will handle the command line request
    @entity = @arguments.shift
    exit_error(103,@entites) if not @entities.include?(@entity.to_sym)

    # Creates a reference to the command class
  	command_class = "EmeraldFW::#{@entity.capitalize}".split('::').inject(Object) {|o,c| o.const_get c}.new(@entity,@arguments,@options)
    command_class.execute
  end



end
