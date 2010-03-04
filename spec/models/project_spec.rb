require 'spec_helper'

describe Project do
  describe 'check' do
    before(:each) do
      @git_fetch = File.read('spec/fixtures/git_fetch.txt')
      @cmd_line_git_fetch = mock(CmdLine)
      @cmd_line_git_fetch.should_receive(:execute).with("cd path && git clean -fdx && git checkout -f && git fetch")
      CmdLine.stub!(:new).and_return(@cmd_line_git_fetch, @cmd_line_git_branch)
    end

    it 'should run a build when commit is detected in git in a branch' do
      project = Project.new(:excluded_branches => 'origin/excluded_branch', :working_dir => 'path')
      Build.should_receive(:run!).with(project, 'origin/master')
      Build.should_receive(:run!).with(project, 'origin/something')
      @cmd_line_git_fetch.stub!(:output).and_return(@git_fetch)
      project.check
    end

    it 'should not run a build when no branches have been committed to' do
      Build.should_not_receive(:run!)
      @cmd_line_git_fetch.stub!(:output).and_return('')
      Project.new(:excluded_branches => 'origin/excluded_branch', :working_dir => 'path').check
    end
  end

  describe 'prepare' do
    before(:each) do
    end

    it 'should create working_dir and clone when working_dir does not exist' do
      File.stub!(:exists?).with('path').and_return(false)
      mock_cmdline = mock(CmdLine)
      CmdLine.stub!(:new).and_return(mock_cmdline)
      mock_cmdline.should_receive(:execute).with("git clone git_url path")
      Project.new(:working_dir => 'path', :clone_from => 'git_url').prepare
    end

    it 'should not clone when working_dir exists' do
      File.should_receive(:exists?).with('path').and_return(true)
      CmdLine.stub!(:new).and_return(mock(CmdLine))
      Project.new(:working_dir => 'path', :clone_from => 'git_url').prepare
    end
  end
end

