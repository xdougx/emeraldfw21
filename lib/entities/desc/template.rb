#
# Auxiliary
#

$entity_obj.entity_type = :template

$entity_obj.valid_commands = [ :list, :create, :remove, :default ]

$entity_obj.entity_base_dir = "#{ENV['HOME']}/emeraldfw/#{$entity_obj.current_project}/web/templates"

$entity_obj.json_file_name = "#{ENV['HOME']}/emeraldfw/#{$entity_obj.current_project}/web/config/templates.json"

def $entity_obj.templates_list
  json = json_contents
  json.keys
end

def $entity_obj.template_exists?(proj)
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


# 
# Command's implementations
# 

def $entity_obj.list
end

def $entity_obj.create
end

def $entity_obj.remove
end

def $entity_obj.default
end