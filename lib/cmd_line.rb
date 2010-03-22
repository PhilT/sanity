class CmdLine
  attr_reader :output

  def execute(cmd, working_dir)
    @output = `cd #{working_dir} && #{cmd} 2>&1`
    log cmd + (@output.blank? ? ' [no response]' : '')
    log @output + "\n\n" unless @output.blank?
    exitstatus = $?.exitstatus
    @success = exitstatus == 0
  end

  def success?
    @success
  end

  def log(message)
    puts message
  end
end

