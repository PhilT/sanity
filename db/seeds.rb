Project.create(:name => 'Sanity', :working_dir => '/home/phil/builds/sanity', :clone_from => 'git@github.com:PhilT/sanity.git', :commands => "rake gems:install db:drop db:create RAILS_ENV=test\nrake db:drop db:create db:schema:load\nmkdir tmp -p\n
rake db:test:prepare spec:rcov")

