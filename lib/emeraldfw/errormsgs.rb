module EmeraldFW

  @errormsgs = {
  	101 => "Invalid number of arguments.",
  	102 => "Invalid command.",
  	103 => "Invalid entity.",
    104 => "Invalid email.",
    105 => "This email is not in the notify list for the current project.",

  	201 => "Project already exists.",
  	202 => "Project does not exist.",
    203 => "No current project is set.",
    211 => "Template already exists.",
    212 => "Template does not exist.",
    213 => "No default template is set."

  }

  # Exit point
 
  def self.exit_error(code,possibilities=[])
    print "Emerald Framework".colorize(:green).bold
    print " says: "
    puts @errormsgs[code].colorize(:light_red).bold
    if not possibilities.empty? then
      puts "It should be:"
      possibilities.each{ |p| puts "  #{p}".colorize(:light_green) }
    end
    exit code
  end

end