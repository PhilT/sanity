class Project < ActiveRecord::Base
  has_many :builds

  def check
    Build.run!(self) if changed?
  end

private
  def changed?
    cmd = CmdLine.new
    branches.each do |branch|
      cmd.execute("cd #{path} && git checkout -f && git pull #{branch.gsub('/', ' ')}")
    end
    logger.debug cmd.output
    cmd.output.match(/Already up-to-date./).nil?
  end

  def branches
    cmd = CmdLine.new
    cmd.execute("cd #{path} && git branch -r")
    excluded = excluded_branches.split(',')
    cmd.output.split("\n").select{|branch| !excluded.include?(branch)}
  end

end

