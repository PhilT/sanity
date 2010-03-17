class Project < ActiveRecord::Base
  has_many :builds, :order => 'created_at DESC'

  validates_presence_of :name
  validates_presence_of :working_dir
  validates_presence_of :clone_from
  validates_presence_of :commands

  def prepare
    cmd = CmdLine.new
    cmd.log 'Cloning #{clone_from}...'
    cmd.execute "git clone #{clone_from} #{working_dir}" unless File.exists?(working_dir)
  end

  def check
    cmdline = CmdLine.new
    if File.exists?(working_dir)
      cmdline.execute "cd #{working_dir} && git clean -fdx && git checkout -f && git fetch"
    else
      prepare
      cmdline.execute "cd #{working_dir} && git br -a"
    end

    branches = cmdline.output.gsub(/origin\/HEAD.+$/, '').scan(/origin\/.+$/)
    excluded = excluded_branches.blank? ? [] : excluded_branches.split(',')
    branches.each do |branch|
      Build.run!(self, branch) unless excluded.include?(branch)
    end
  end
end

