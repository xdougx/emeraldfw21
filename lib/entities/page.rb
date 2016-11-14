module EmeraldFW

  class Page < EmeraldFW::Entity

    def initialize(args,opts)
      @project = EmeraldFW::Project.new(args,opts)
      EmeraldFW.exit_error(203) if @project.current_project.empty?
      page_file_generate if not File.exist?(pages_json_file)
      @valid_options = [ :template ]
      super(args,opts)
    end

  	def entity_type
  	  :page 
  	end

  	def valid_commands
  	  [ :list, :create, :remove ]
  	end

  	def pages_base_dir
  	  "#{ENV['HOME']}/emeraldfw/#{@project.current_project}/web/views/pages"
  	end

  	def pages_json_file
      "#{ENV['HOME']}/emeraldfw/#{@project.current_project}/config/pages.json"
  	end

    def page_file_generate
      File.open(pages_json_file,"w") do |f| 
        f.write(JSON.pretty_generate(pages_file_basic_structure))
      end
    end

    def pages_file_basic_structure
      {
        "index": {
          "template": "default",
          "insertion_point": {
            "tag": "body"
          }
        }
      }
    end

  	def pages_json
  	  json_contents(pages_json_file)
  	end

  	def pages_list
  	  pages_json.keys
  	end

  	def page_exists?(temp)
  	  pages_list.include?(temp)
  	end

    def page_name
      @args[2]
    end

  	# 
  	# Command's implementations
  	# 

  	def list
  	  print "Emerald Framework ".colorize(:green).bold
  	  print " - Project "
      print "#{@project.current_project} ".colorize(:light_green)
      puts  "pages:"
  	  pages_list.each do |p|
  	    puts "  * #{p}".colorize(:light_green)
  	  end
  	end

  	def create
      EmeraldFW.exit_error(203) if @project.current_project.empty?
  	  EmeraldFW.exit_error(211) if page_exists?(page_name)
      # Create the page file and its initial content
      File.open("#{pages_base_dir}/#{page_name}.html","w") do |f| 
        f.write(page_basic_content)
      end
  	  json = pages_json
  	  json[page_name] = { "template": "default", "insertion_point": { "tag": "body" } }
  	  json_write(pages_json_file,json)
  	end

  	def remove
  	  EmeraldFW.exit_error(222) if not page_exists?(page_name)
  	  FileUtils.rm_rf("#{pages_base_dir}/#{page_name}.html")
  	  json = pages_json
  	  json.delete(page_name)
  	  json_write(pages_json_file,json)
  	end

    def page_basic_content
      "<h2>#{page_name}.html</h2>\n<h3>This page may be found at #{pages_base_dir}.</h3>"
    end

  end

end