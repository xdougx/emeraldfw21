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
  	end

  	def create
  	end

  	def remove
  	end 	

  end

end