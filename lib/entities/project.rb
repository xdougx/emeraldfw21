require 'zip'

module EmeraldFW

  class Project < EmeraldFW::Entity

  	def entity_type
  	  :project
  	end

  	def valid_commands
  	  [ :list, :create, :remove, :current, :notify, :unnotify ]
  	end

  	def projects_base_dir
  	  "#{ENV['HOME']}/emeraldfw"
  	end

  	def projects_json_file
      "#{projects_base_dir}/emerald_projects.json"
  	end

  	def projects_json
  	  json_contents(projects_json_file)
  	end

  	def projects_list
  	  projects_json['projects']
  	end

  	def project_exists?(proj)
  	  projects_list.include?(proj)
  	end

  	def current_project
  	  projects_json['current']
  	end

    def project_name
      @args[2]
    end

  	def unzip_project_files
  	  this_path = File.expand_path("../../../files", __FILE__)
  	  app_structure_file = "#{this_path}/appstructure-ef.zip"
  	  Zip::File.open(app_structure_file) do |zip_file|
  	    zip_file.each do |entry|
  	      entry_arr = entry.name.split('/')
  	      entry_arr.shift
  	      dest_file_name = entry_arr.join('/')
  	      dest_file = "#{projects_base_dir}/#{project_name}/#{dest_file_name}"
  	      puts dest_file
  	      FileUtils.rm_f(dest_file) if File.exist?(dest_file)
  	      entry.extract(dest_file)
  	    end
  	  end
  	end  	

  	# 
  	# Command's implementations
  	# 

  	def list
  	  print "Emerald Framework ".colorize(:green)
  	  puts "project\'s list:"
  	  projects_list.each do |p|
  	    print "  * #{p}".colorize(:light_green)
  	    puts (p == current_project) ? " (current)" : ""
  	  end
  	end

  	def create
  	  EmeraldFW.exit_error(201) if project_exists?(project_name)
  	  FileUtils.mkdir_p("#{projects_base_dir}/#{project_name}")
  	  unzip_project_files
  	  json = projects_json
  	  json['projects'].push(project_name)
  	  json['current'] = project_name
  	  json[project_name] = {}
  	  json[project_name]['notify_list'] = []
  	  json_write(projects_json_file,json)
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

  	def current
  	  EmeraldFW.exit_error(202) if not project_exists?(project_name)
  	  json = projects_json
  	  json['current'] = project_name
  	  json_write(projects_json_file,json)
  	end

  	def notify
  	  EmeraldFW.exit_error(104) if not valid_email?(email)
  	  EmeraldFW.exit_error(203,projects_list) if current_project.empty?
  	  json = projects_json
  	  project_key = current_project
  	  json[project_key]['notify_list'].push(email)
  	  json_write(projects_json_file,json)
  	end

  	def unnotify
  	  EmeraldFW.exit_error(104) if not valid_email?(email)
  	  EmeraldFW.exit_error(105) if not email_in_notify_list?(email)
  	  json = projects_json
  	  project_key = current_project
  	  json[project_key]['notify_list'].delete(email)
  	  json_write(projects_json_file,json)
  	end
  end

end