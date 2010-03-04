class Project < ActiveRecord::Base
  has_many :builds

  def check
    cmd = CmdLine.new
    cmd.execute("cd #{working_dir} && git clean -fdx && git checkout -f && git fetch")
    branches = cmd.output.scan(/origin\/.+$/)
    excluded = excluded_branches.split(',')
    branches.each do |branch|
      Build.run!(self, branch) unless excluded.include?(branch)
    end
  end
end

