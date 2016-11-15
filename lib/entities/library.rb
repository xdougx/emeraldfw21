require 'httparty'

module EmeraldFW

  class Library < EmeraldFW::Entity

  	def initialize(args,opts)
  	  @project = EmeraldFW::Project.new(args,opts)  
  	  EmeraldFW.exit_error(203) if @project.current_project.empty?		
  	  @valid_options = []
  	  super(args,opts)
  	end

  	def entity_type
  	  :library
  	end

  	def valid_commands
  	  [ :list, :create, :remove ]
  	end

  	def libraries_base_dir
  	  "#{ENV['HOME']}/emeraldfw/#{@project.current_project}/web/libraries"
  	end

  	def libraries
  	  Dir.entries(libraries_base_dir).reject { |d| (d == '.') || (d == '..') }.sort
  	end

  	# 
  	# Command's implementations
  	# 

  	def list
  	  print "Project "
  	  print @project.current_project.colorize(:green)
  	  puts "'s libraries: "
  	  libraries.each do |lib|
  	  	puts  "   #{lib}".colorize(:light_green)
  	  end
  	end

  	def create
  	  EmeraldFW.exit_error(231) if File.exist?("#{libraries_base_dir}/#{entity_name}")
  	  zip_file = HTTParty.get("https://codeload.github.com/EmeraldFramework/#{entity_name}-ef/zip/master")
  	  tempfile = Tempfile.new('zipfile.zip').tap do |f|
  	    f.write(zip_file.to_s)
  	  end
  	  Zip::File.open(tempfile) do |zip_file|
  	    zip_file.each do |entry|
  	      puts "Extracting #{entry.name}".gsub('-ef-master','')
  	      entry_arr = entry.name.split('/')
  	      base_dir = entry_arr.shift
  	      dest_file_name = entry_arr.join('/')
  	      dest_file = "#{libraries_base_dir}/#{entity_name}/#{dest_file_name}".gsub('-ef-master','')
  	      FileUtils.rm_f(dest_file) if File.exist?(dest_file)
  	      entry.extract(dest_file)
  	    end
  	  end
  	end

  	def remove
  	  EmeraldFW.exit_error(232,libraries) if not File.exist?("#{libraries_base_dir}/#{entity_name}")
  	  FileUtils.rm_rf("#{libraries_base_dir}/#{entity_name}",:verbose => true)
  	end 	

  end

end