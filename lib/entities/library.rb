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

  	# 
  	# Command's implementations
  	# 

  	def list
  	  print "Project "
  	  print @project.current_project.colorize(:green)
  	  puts "'s libraries: "
  	  libraries = Dir.entries(libraries_base_dir).reject { |d| (d == '.') || (d == '..') }.sort
  	  libraries.each do |lib|
  	  	puts  "   #{lib}".colorize(:light_green)
  	  end
  	end

  	def create
  	end

  	def remove
  	end 	

  end

end