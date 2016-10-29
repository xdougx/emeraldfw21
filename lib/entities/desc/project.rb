#
# Auxiliary
#

$entity_obj.entity_type = :project

$entity_obj.valid_commands = [ :list, :create, :remove, :current, :notify, :unnotify ]

$entity_obj.entity_base_dir = "#{ENV['HOME']}/emeraldfw"

$entity_obj.json_file_name = "#{$entity_obj.entity_base_dir}/emerald_projects.json"

def $entity_obj.project_list
  json = json_contents
  json['projects']
end

def $entity_obj.project_exists?(proj)
  $entity_obj.project_list.include?(proj)
end

def $entity_obj.project_name
  @args[2]
end

def $entity_obj.email
  @args[2]
end

#
# TODO:
# - Write an email validation method using a regular expression
# - Put is somewhere else and use inheritance or a mixin to insert it in Entity
#
def $entity_obj.valid_email?(email)
  true
end

def $entity_obj.email_in_notify_list?(email)
  json = json_contents
  json[json['current']]['notify_list'].include?(email)
end

def $entity_obj.current_project
  json = json_contents
  json['current']
end

def $entity_obj.unzip_project_files
  this_path = File.expand_path("../../../../files", __FILE__)
  app_structure_file = "#{this_path}/appstructure-ef.zip"
  Zip::File.open(app_structure_file) do |zip_file|
    zip_file.each do |entry|
      entry_arr = entry.name.split('/')
      base_dir = entry_arr.shift
      dest_file_name = entry_arr.join('/')
      dest_file = "#{entity_base_dir}/#{$entity_obj.project_name}/#{dest_file_name}"
      puts dest_file
      FileUtils.rm_f(dest_file) if File.exist?(dest_file)
      entry.extract(dest_file)
    end
  end
end

# 
# Command's implementations
# 

def $entity_obj.list
  print "Emerald Framework ".colorize(:green)
  puts "project\'s list:"
  $entity_obj.project_list.each do |p|
    print "  * #{p}".colorize(:light_green)
    puts (p == $entity_obj.current_project) ? " (current)" : ""
  end
end

def $entity_obj.create
  EmeraldFW.exit_error(201) if $entity_obj.project_exists?($entity_obj.project_name)
  FileUtils.mkdir_p("#{$entity_obj.entity_base_dir}/#{$entity_obj.project_name}")
  $entity_obj.unzip_project_files
  json = json_contents
  json['projects'].push($entity_obj.project_name)
  json['current'] = $entity_obj.project_name
  json[$entity_obj.project_name] = {}
  json[$entity_obj.project_name]['notify_list'] = []
  $entity_obj.json_write(json)
end

def $entity_obj.remove
  EmeraldFW.exit_error(202) if not $entity_obj.project_exists?($entity_obj.project_name)
  json = json_contents
  json['projects'].delete($entity_obj.project_name)
  json['current'] = "" if json['current'] == $entity_obj.project_name
  json.delete($entity_obj.project_name)
  $entity_obj.json_write(json)
end

def $entity_obj.current
  EmeraldFW.exit_error(202) if not $entity_obj.project_exists?($entity_obj.project_name)
  json = json_contents
  json['current'] = $entity_obj.project_name
  $entity_obj.json_write(json)
end

def $entity_obj.notify
  EmeraldFW.exit_error(104) if not $entity_obj.valid_email?($entity_obj.email)
  json = json_contents
  project_key = $entity_obj.current_project
  json[project_key]['notify_list'].push($entity_obj.email)
  $entity_obj.json_write(json)
end

def $entity_obj.unnotify
  EmeraldFW.exit_error(104) if not $entity_obj.valid_email?($entity_obj.email)
  EmeraldFW.exit_error(105) if not $entity_obj.email_in_notify_list?($entity_obj.email)
  json = json_contents
  project_key = $entity_obj.current_project
  json[project_key]['notify_list'].delete($entity_obj.email)
  $entity_obj.json_write(json)
end