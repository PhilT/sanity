require 'spec_helper'

describe Project do
  before(:each) do
    @cmd_line_git_branch = mock(CmdLine)
    @cmd_line_git_branch.should_receive(:execute).with("cd path && git branch -r")
    @cmd_line_git_branch.should_receive(:output).and_return("origin/master\norigin/excluded_branch\n")

    @cmd_line_git_pull = mock(CmdLine)
    @cmd_line_git_pull.should_receive(:execute).with("cd path && git checkout -f && git pull origin master")
    CmdLine.stub!(:new).and_return(@cmd_line_git_pull, @cmd_line_git_branch)
  end

  it 'should run a build when commit is detected in git in a branch' do
    Build.should_receive(:run!)
    @cmd_line_git_pull.stub!(:output).and_return('')
    Project.new(:excluded_branches => 'origin/excluded_branch', :path => 'path').check
  end

  it 'should not run a build when no branches have been committed to' do
    Build.should_not_receive(:run!)
    @cmd_line_git_pull.stub!(:output).and_return('Already up-to-date.')
    Project.new(:excluded_branches => 'origin/excluded_branch', :path => 'path').check
  end
end

