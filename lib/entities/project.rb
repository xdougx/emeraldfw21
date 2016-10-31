module EmeraldFW

  class Project < EmeraldFW::Entity

  	def entity_type
  	  :project
  	end

  	def valid_commands
  	  [ :list, :create, :remove, :current, :notify, :unnotify ]
  	end

  	def 
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

  	def unzip_project_files
  	  this_path = File.expand_path("../../../../files", __FILE__)
  	  app_structure_file = "#{this_path}/appstructure-ef.zip"
  	  Zip::File.open(app_structure_file) do |zip_file|
  	    zip_file.each do |entry|
  	      entry_arr = entry.name.split('/')
  	      entry_arr.shift
  	      dest_file_name = entry_arr.join('/')
  	      dest_file = "#{projects_base_dir}/#{$entity_obj.project_name}/#{dest_file_name}"
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
  	  $entity_obj.projects_list.each do |p|
  	    print "  * #{p}".colorize(:light_green)
  	    puts (p == $entity_obj.current_project) ? " (current)" : ""
  	  end
  	end

  	def create
  	  EmeraldFW.exit_error(201) if $entity_obj.project_exists?($entity_obj.project_name)
  	  FileUtils.mkdir_p("#{$entity_obj.projects_base_dir}/#{$entity_obj.project_name}")
  	  $entity_obj.unzip_project_files
  	  json = $entity_obj.projects_json
  	  json['projects'].push($entity_obj.project_name)
  	  json['current'] = $entity_obj.project_name
  	  json[$entity_obj.project_name] = {}
  	  json[$entity_obj.project_name]['notify_list'] = []
  	  $entity_obj.json_write(projects_json_file,json)
  	end

  	def remove
  	  EmeraldFW.exit_error(202) if not $entity_obj.project_exists?($entity_obj.project_name)
  	  FileUtils.rm_rf("#{$entity_obj.projects_base_dir}/#{$entity_obj.project_name}")
  	  json = $entity_obj.projects_json
  	  json['projects'].delete($entity_obj.project_name)
  	  json['current'] = "" if json['current'] == $entity_obj.project_name
  	  json.delete($entity_obj.project_name)
  	  $entity_obj.json_write(projects_json_file,json)
  	end

  	def current
  	  EmeraldFW.exit_error(202) if not $entity_obj.project_exists?($entity_obj.project_name)
  	  json = $entity_obj.projects_json
  	  json['current'] = $entity_obj.project_name
  	  $entity_obj.json_write(projects_json_file,json)
  	end

  	def notify
  	  EmeraldFW.exit_error(104) if not $entity_obj.valid_email?($entity_obj.email)
  	  EmeraldFW.exit_error(203,$entity_obj.projects_list) if $entity_obj.current_project.empty?
  	  json = $entity_obj.projects_json
  	  project_key = $entity_obj.current_project
  	  json[project_key]['notify_list'].push($entity_obj.email)
  	  $entity_obj.json_write(projects_json_file,json)
  	end

  	def unnotify
  	  EmeraldFW.exit_error(104) if not $entity_obj.valid_email?($entity_obj.email)
  	  EmeraldFW.exit_error(105) if not $entity_obj.email_in_notify_list?($entity_obj.email)
  	  json = $entity_obj.projects_json
  	  project_key = $entity_obj.current_project
  	  json[project_key]['notify_list'].delete($entity_obj.email)
  	  $entity_obj.json_write(projects_json_file,json)
  	end
  end

end