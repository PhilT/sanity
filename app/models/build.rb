class Build < ActiveRecord::Base
  belongs_to :project
  include AASM
  aasm_column :state
  aasm_state :started
  aasm_state :completed
  aasm_state :failed
  aasm_initial_state :started

  aasm_event :complete do
    transitions :from => :started, :to => :completed
  end
  aasm_event :fail do
    transitions :from => :started, :to => :failed
  end
  aasm_event :next_state do
    transitions :from => :pending, :to => :started
    transitions :from => :started, :to => :completed
  end

  def self.run!
    begin
      build = create!
      log_state
      COMMANDS.each do |cmd|
        break unless CmdLine.new.execute("cd #{project.path} && #{cmd}")
      end
    rescue
      logger.error "Could not create build"
    end
  end

  def initialize(attributes = {})
    super

    range = Build.last.commit_hash + '..HEAD' if Build.count > 0
    stat_output = CmdLine.new.execute("git log --numstat #{range}")
    stat_output.split(/^commit /).reverse.each do |details|
      parse_commit_details(details) unless details.empty?
    end
  end

  def started_at
    self.created_at
  end

private
  def parse_commit_details(details)
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

  def log_state
    logger.info "Build #{state}"
  end
end

