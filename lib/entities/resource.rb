module EmeraldFW

  class Resource < EmeraldFW::Entity

  	def initialize(args,opts)
  	  @project = EmeraldFW::Project.new(args,opts)  
  	  EmeraldFW.exit_error(203) if @project.current_project.empty?		
  	  @valid_options = [ :rlibrary ]
  	  super(args,opts)
  	end

  	def entity_type
  	  :resource
  	end

  	def valid_commands
  	  [ :list, :create, :remove ]
  	end

  	def resources_base_dir
  	  "#{ENV['HOME']}/emeraldfw/#{@project.current_project}/web/resources"
  	end

  	# 
  	# Command's implementations
  	# 

  	def list
  	  print "Project: "
  	  print @project.current_project.colorize(:green)
      puts "'s resources: "
  	  rlibs = Dir.entries(resources_base_dir).reject { |d| (d == '.') || (d == '..') }.sort
  	  rlibs.each do |lib| 
  	  	print "   Resource library: "
  	  	puts  lib.colorize(:light_green)
  	  	assets = Dir.entries("#{resources_base_dir}/#{lib}").reject { |d| (d == '.') || (d == '..') }.sort
  	  	assets.each do |asset|
  	  	  puts "      #{asset}"
  	  	end
  	  end
  	end

  	def create
  	  library = @opts[:rlibrary]
  	  library_dir = "#{resources_base_dir}/#{library}"
  	  FileUtils.mkdir_p(library_dir) if not File.exist?(library_dir)
  	  resource_file = "#{entity_name}"
  	  FileUtils.mv(resource_file,library_dir,:verbose => true)
  	end

  	def remove
  	  resource_file = "#{resources_base_dir}/#{@opts[:rlibrary]}/#{entity_name}"
  	  FileUtils.rm_f(resource_file,:verbose => true)
  	end 	

  end

end