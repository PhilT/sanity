class CmdLine
  attr_reader :output
  def initialize(enable_logging = true)
    @enable_logging = enable_logging
  end

  def execute(cmd)
    log "=== RUN #{cmd} ==="
    @output = `#{cmd} 2>&1`
    exitstatus = $?.exitstatus
    log "=== END #{cmd} ===\n"
    @success = exitstatus == 0
  end

  def success?
    @success
  end

private
  def log(message)
    puts message if @enable_logging
  end
end

