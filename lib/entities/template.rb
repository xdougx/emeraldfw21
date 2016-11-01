require 'zip'

module EmeraldFW

  class Template < EmeraldFW::Entity

    def initialize(args,opts)
      @project = EmeraldFW::Project.new(args,opts)
      EmeraldFW.exit_error(203) if @project.current_project.empty?
      template_file_generate if not File.exist?(templates_json_file)
      super(args,opts)
    end

  	def entity_type
  	  :template 
  	end

  	def valid_commands
  	  [ :list, :create, :remove, :default ]
  	end

  	def templates_base_dir
  	  "#{ENV['HOME']}/emeraldfw/#{@project.current_project}/web/views/templates"
  	end

  	def templates_json_file
      "#{ENV['HOME']}/emeraldfw/#{@project.current_project}/config/templates.json"
  	end

    def template_file_generate
      File.open(templates_json_file,"w") do |f| 
        f.write(JSON.pretty_generate(templates_file_basic_structure))
      end
    end

    def templates_file_basic_structure
      {
        "default": "default",
        "templates": {
          "default": {
            "libraries": []
          }
        }
      }
    end

  	def templates_json
  	  json_contents(templates_json_file)
  	end

  	def templates_list
  	  templates_json['templates'].keys
  	end

  	def template_exists?(temp)
  	  templates_list.include?(temp)
  	end

  	def default_template
  	  templates_json['default']
  	end

    def template_name
      @args[2]
    end

  	# 
  	# Command's implementations
  	# 

  	def list
  	  print "Emerald Framework ".colorize(:green).bold
  	  print " - Project "
      print "#{@project.current_project} ".colorize(:light_green)
      puts  "templates:"
  	  templates_list.each do |t|
  	    print "  * #{t}".colorize(:light_green)
  	    puts (t == default_template) ? " (default)" : ""
  	  end
  	end

  	def create
  	  EmeraldFW.exit_error(201) if template_exists?(template_name)
      EmeraldFW.exit_error(203) if @project.current_project.empty?
      # Create the template file and its initial content
      FileUtils.touch("#{templates_base_dir}/#{template_name}.html")
      # TODO: Include the basic contents of the new template
  	  json = templates_json
  	  json['templates'][template_name] = { "libraries": [] }
      # TODO: Include the libraries choosen
  	  json['default'] = template_name
  	  json_write(templates_json_file,json)
  	end

  	def remove
  	  EmeraldFW.exit_error(202) if not project_exists?(project_name)
  	  FileUtils.rm_rf("#{projects_base_dir}/#{project_name}")
  	  json = projects_json
  	  json['projects'].delete(project_name)
  	  json['current'] = "" if json['current'] == project_name
  	  json.delete(project_name)
  	  json_write(projects_json_file,json)
  	end

  	def default
  	  EmeraldFW.exit_error(202) if not project_exists?(project_name)
  	  json = projects_json
  	  json['current'] = project_name
  	  json_write(projects_json_file,json)
  	end

  end

end