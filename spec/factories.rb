Factory.define :build do |f|
end

Factory.define :project do |f|
  f.name 'a project'
  f.working_dir 'project_path/'
  f.clone_from 'git repo'
  f.commands "this is what will be run\nanother command"
end

