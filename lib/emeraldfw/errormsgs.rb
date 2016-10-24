module EmeraldFW

  @errormsgs = {
  	101 => "Invalid number of arguments.",
  	102 => "Invalid command.",
  	103 => "Invalid entity.",

  	201 => "Project already exists.",
  	202 => "Project does not exist."
  }

  # Exit point
 
  def self.exit_error(code,possibilities=[])
    print "Emerald Framework says: "
    puts @errormsgs[code].colorize(:light_red).bold
    if not possibilities.empty? then
      puts "It should be:"
      possibilities.each{ |p| puts "  #{p}".colorize(:light_green) }
    end
    exit code
  end

end