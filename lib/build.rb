class Build < Struct.new(:working_dir, :branch)

  def run
    return unless run?
    log "Starting build at #{Time.now.to_s}..."
    commands = [
      'gems:install RAILS_ENV=test',
      'db:migrate && db:test:prepare',
      'default'
    ]
    commands << 'cucumber' if File.exists?('features')
    success = false
    commands.each do |cmd|
      success = rake(cmd)
      break unless success
    end
    log 'BUILD ' + (success ? 'PASSED!' : 'FAILED!')
  end

private
  def run?
    cmd = "cd #{working_dir} && git pull origin #{branch || 'master'}"
    log cmd
    output = `#{cmd}`
    log output, 'GIT '
    output.match(/Already up-to-date./).nil?
  end

  def rake(cmd)
    cmd = "cd #{working_dir} && rake #{cmd} 2>&1"
    log cmd
    output = `#{cmd}`
    exitstatus = $?.exitstatus
    log output, 'RAKE'
    log "exitstatus=#{exitstatus}"
    exitstatus == 0
  end

  def log(output, cmd = nil)
    puts "[#{cmd}]" if cmd
    puts "#{output}"
    puts "[#{cmd}] end." if cmd
  end
end

