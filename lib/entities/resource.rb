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
  	  puts @project.current_project.colorize(:green)
  	  rlibs = Dir.entries(resources_base_dir).reject{ |d| (d == '.') || (d == '..') }.sort
  	  rlibs.each do |lib| 
  	  	print "   Resource library: "
  	  	puts  lib.colorize(:light_green)
  	  	assets = Dir.entries("#{resources_base_dir}/#{lib}").reject{ |d| (d == '.') || (d == '..') }.sort
  	  	assets.each do |asset|
  	  	  puts "      #{asset}"
  	  	end
  	  end
  	end

  	def create
  	  
  	end

  	def remove
  	end 	

  end

end