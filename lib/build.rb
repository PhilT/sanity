require 'logger'

class Build < Struct.new(:working_dir, :branch)

  attr_reader :log

  def initialize(struct)
    super
    @log = Logger.new('log/build.log')
  end

  def run
    return unless run?
    log.info "Starting build at #{Time.now.strftime("%Y-%m-%d %H:%M")}..."
    cucumber = File.exists?('features') ? 'cucumber' : ''
    commands = [
      'rake gems:install RAILS_ENV=test',
      'rake db:migrate db:test:prepare default #{cucumber}'
    ]
    success = false
    commands.each do |cmd|
      success = rake(cmd)
      break unless success
    end
    if success?
      log.info 'BUILD SUCCESSFUL!'
    else
      log.error 'BUILD FAILED!'
    end
  end

private
  def run?
    log.info 'Checking Git...'
    `cd #{working_dir} && git pull origin #{branch || 'master'}`.match(/Already up-to-date./).nil?
  end

  def rake(cmd)
    cmd = "cd #{working_dir} && #{cmd} 2>&1"
    log.info cmd
    output = `#{cmd}`
    exitstatus = $?.exitstatus
    log.info output
    exitstatus == 0
  end
end

