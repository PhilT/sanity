require 'active_record'
require 'yaml'
require 'logger'

APP_ROOT = File.join(File.dirname(File.expand_path(__FILE__)), '..')
require File.join(APP_ROOT, 'app/models/project')

class Build
  attr_reader :log, :project

  def initialize
    @log = Logger.new(File.join(APP_ROOT, 'log/build.log'))
    db_config = YAML::load(File.open(File.join(APP_ROOT, 'config/database.yml')))['development']
    db_config['database'] = File.join(APP_ROOT, db_config['database'])
    ActiveRecord::Base.establish_connection(db_config)
    @project = Project.first
  end

  def run
    return unless run?
    log.info "Running build..."
    cucumber = File.exists?(File.join(project.path, 'features')) ? 'cucumber' : ''
    commands = [
      'rake gems:install RAILS_ENV=test',
      'rake db:migrate db:test:prepare default #{cucumber}'
    ]
    success = false
    commands.each do |cmd|
      success = rake(cmd)
      break unless success
    end
    if success
      log.info 'BUILD SUCCESSFUL!'
    else
      log.error 'BUILD FAILED!'
    end
  end

private
  def run?
    run = `cd #{project.path} && git pull origin #{project.branch || 'master'}`.match(/Already up-to-date./).nil?
    log.info run ? 'Code pushed to Git.' : 'No changes in Git.'
    run
  end

  def rake(cmd)
    cmd = "cd #{project.path} && #{cmd} 2>&1"
    log.info cmd
    output = `#{cmd}`
    exitstatus = $?.exitstatus
    log.info output
    exitstatus == 0
  end
end

