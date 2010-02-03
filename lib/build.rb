class Build < Struct.new(:working_dir, :branch)

  def run
    return unless run?
    log "\nStarting build at #{Time.now.strftime("%Y-%m-%d %H:%M")}..."
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
    log 'BUILD ' + (success ? 'PASSED!' : 'FAILED!')
  end

private
  def run?
    `cd #{working_dir} && git pull origin #{branch || 'master'}`.match(/Already up-to-date./).nil?
  end

  def rake(cmd)
    cmd = "cd #{working_dir} && #{cmd} 2>&1"
    log cmd, 'RUN '
    output = `#{cmd}`
    exitstatus = $?.exitstatus
    log output, 'RAKE'
    exitstatus == 0
  end

  def log(output, cmd = nil)
    puts (cmd ? "[#{cmd}] " : '') + "#{output}"
  end
end

