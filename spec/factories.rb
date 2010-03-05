Factory.define :build do |f|
end

Factory.define :project do |f|
  f.working_dir 'project_path/'
  f.commands "this is what will be run\nanother command"
end

