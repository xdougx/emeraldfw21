$entity_block = lambda { |ent|

  ent.entity_type    = :project
  ent.valid_commands = [ :list, :create, :remove, :current, :notify, :unnotify ]
  
  base_dir           = "#{ENV['HOME']}/emeraldfw"
  config_file        = "#{base_dir}/emerald_projects.json"
  json               = JSON.load(File.read(config_file))

  json_write         = lambda {
  	File.open(config_file,"w") do |f| 
  	  f.write(JSON.pretty_generate(json))
  	end  	
  }

  ent.create         = lambda { |args,opts|
  	name = args[2]
  	FileUtils.mkdir("#{base_dir}/#{name}")
  	json['projects'].push(name)
  	json['current'] = name
  	json[name] = {}
  	json_write.call
  }

  ent.remove         = lambda { |name|
  	FileUtils.rm_rf("#{base_dir}/#{name}")
  	json['projects'].delete(name)
  	json['current'] = "" if json['current'] == name
  	json.delete(name)
  	json_write.call
  }

}