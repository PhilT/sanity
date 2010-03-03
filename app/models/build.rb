class Build < ActiveRecord::Base
  belongs_to :project

  def self.run!(project)
    range = Build.last.commit_hash + '..HEAD' if Build.count > 0
    stat_output = CmdLine.new.execute("git log --numstat #{range}")
    stat_output.split(/^commit /).reverse.each do |details|
      build = new(:project => project)
      build.parse_commit(details) unless details.empty?
      build.save
      build.run
    end
  end

  def run
    COMMANDS.each do |cmd|
      break unless CmdLine.new.execute("cd #{project.path} && #{cmd}")
    end
  end

  def started_at
    self.created_at
  end

  def parse_commit(details)
    stat_lines = details.split("\n")
    self.commit_hash = stat_lines[0]
    self.author = stat_lines[1].scan(/Author: (.+)/).join
    self.committed_at = stat_lines[2].scan(/Date: (.+)/).join
    self.commit_message = ""

    changes = []
    message = []
    stat_lines[3..-1].each do |line|
      if line.match(/^    /)
        message << line.scan(/^    (.+)/).join
      elsif line != ""
        scanned = line.scan(/^[0-9]+\s[0-9]+\s(.+)/).join
        changes << scanned

      end
    end
    self.commit_message = message.join("\n")
    self.changed_files = changes.join(',')
  end
end

