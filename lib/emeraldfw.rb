require 'json'
require 'colorize'

require "emeraldfw/errormsgs"
require "emeraldfw/version"

require "entities/entity"
require "entities/component"
require "entities/email"
require "entities/form"
require "entities/integration"
require "entities/library"
require "entities/page"
require "entities/project"
require "entities/resource"
require "entities/template"

module EmeraldFW

  @entities = [ :component, :email, :form, :library, :page, :project, :resource, :template, :integration, :notification ].sort

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
    exit_error(103,@entities) if not @entities.include?(@entity.to_sym)

    # Creates an instante of the entity class
    entity_class = "EmeraldFW::#{@entity.capitalize}".split('::').inject(Object) {|o,c| o.const_get c}
    entity_instance = entity_class.new(@arguments,@options)
    entity_instance.execute_command

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
