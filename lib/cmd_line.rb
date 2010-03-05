class CmdLine
  attr_reader :output
  def initialize(enable_logging = true)
    @enable_logging = enable_logging
  end

  def execute(cmd)
    failure_text = cmd.match('rake')? /rake aborted!/ : /not found/
    log "=== RUN #{cmd} ==="
    cmd_out = File.expand_path('tmp/cmd.out')
    system "#{cmd} 2>&1 | tee #{cmd_out}"
    @output = File.read(cmd_out)
    log "=== END #{cmd} ===\n\n"
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

