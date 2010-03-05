class CmdLine
  attr_reader :output
  def initialize(enable_logging = true)
    @enable_logging = enable_logging
  end

  def execute(cmd)
    failure_text = cmd.match('rake')? /rake aborted!/ : /not found/
    log "=== RUN #{cmd} ==="
    system "#{cmd} 2>&1 | tee tmp/cmd.out"
    @output = File.read('tmp/cmd.out')
    log(@output)
    log "=== END #{cmd} ===\n"
    @success = (@output =~ failure_text).nil?
  end

  def success?
    @success
  end

private
  def log(message)
    puts message if @enable_logging
  end
end

