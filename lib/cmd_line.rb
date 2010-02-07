class CmdLine
  attr_reader :output

  def execute(cmd)
    @output = `#{cmd} 2>&1`
    exitstatus = $?.exitstatus
    @success = exitstatus == 0
  end

  def success?
    @success
  end
end

