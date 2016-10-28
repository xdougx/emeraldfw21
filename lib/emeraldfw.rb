require 'json'
require 'colorize'

require "emeraldfw/errormsgs"
require "emeraldfw/version"

require "entities/entity"

module EmeraldFW

  @entities = [ :component, :email, :form, :library, :page, :project, :resource, :template ].sort

  def self.emeraldfw_init
    FileUtils.mkdir_p(emerald_projects_dir) if not File.exist?(emerald_projects_dir)
    config_file_generate if not File.exist?(emerald_config_file)
  end

  def self.start(args,opts)
    # Initializes the framework workspace if needed
    emeraldfw_init

    # Saves arguments and options
  	@arguments = args
    @options = opts

    # Isolates the entity which will handle the command line request
    @entity = @arguments[0]
    exit_error(103,@entites) if not @entities.include?(@entity.to_sym)

    # Requires the correct block for the entity type
    require "entities/#{@entity}"

    # Creates a reference to the command class
  	entity_class = EmeraldFW::Entity.new(@arguments,@options)
    $entity_block.call(entity_class)
    entity_class.execute
  end

  def self.emerald_projects_dir
    "#{ENV['HOME']}/emeraldfw"
  end

  def self.emerald_config_file
    "#{EmeraldFW.emerald_projects_dir}/emerald_projects.json"
  end

  def self.config_file_generate
    File.open(emerald_config_file,"w") do |f|
      f.write(JSON.pretty_generate(config_file_basic_structure))
    end
  end

  def self.config_file_basic_structure
    {
      "projects": [],
      "current": ""
    }
  end

end
