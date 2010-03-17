class CmdLine
  attr_reader :output
  def initialize(enable_logging = true)
    @enable_logging = enable_logging
  end

  def execute(cmd)
    @output = `#{cmd} 2>&1`
    log cmd + (@output.blank? ? ' [no response]' : '')
    log @output + "\n\n" unless @output.blank?
    exitstatus = $?.exitstatus
    @success = exitstatus == 0
  end

  def success?
    @success
  end

  def log(message)
    puts message if @enable_logging
  end
end

