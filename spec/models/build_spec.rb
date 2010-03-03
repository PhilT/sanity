require 'spec_helper'

describe Build do
  before(:each) do
    @project = Factory(:project)
    @mock_cmd_line = mock(CmdLine)
    CmdLine.stub!(:new).and_return @mock_cmd_line
    @git_log_stat = IO.readlines('spec/fixtures/git_log_numstat.txt','').to_s
    @mock_cmd_line.stub!(:execute).with('git log --numstat ').and_return(true)
    @mock_cmd_line.stub!(:output).and_return(@git_log_stat)
    @mock_cmd_line.stub!(:execute).with("cd #{@project.path} && #{COMMANDS[0]}").and_return(true)
    @mock_cmd_line.stub!(:execute).with("cd #{@project.path} && #{COMMANDS[1]}").and_return(true)
  end

  it 'should parse git log --stat messages' do
    Build.run!(@project)
    build = Build.last
    build.commit_hash.should == '6c59a90cb8a31442276e808ca745a35311d244bf'
    build.author.should == 'A Developer <phil@example.com>'
    build.committed_at.should == DateTime.new(2010, 2, 3, 4, 59, 49)
    build.commit_message.should == "This is the commit message. It can be as long as you like\nand have new lines. It's indented to show where it finishes."
    build.changed_files.should == 'db/migrate/20100203025923_create_projects.rb,db/schema.rb,db/seeds.rb,lib/build.rb,script/build_runner'
  end

  it 'should check for commits from the last one in the builds table' do
    commit_hash = '6c59a90cb8a31442276e808ca745a35311d244be'
    previous_build = Factory(:build, :commit_hash => commit_hash, :project => @project)

    @mock_cmd_line.should_receive(:execute).with("git log --numstat #{commit_hash}..HEAD").and_return(true)
    Build.run!(@project)
  end

  it 'should create a new build for each new commit' do
    proc { Build.run!(@project) }.should change(Build, :count).by(2)
  end

  it 'should have a completed date when complete' do
    Build.run!(@project)
    Build.last.completed_at.to_date.should == Date.today
  end

  it 'should set success flag when complete' do
    Build.run!(@project)
    Build.last.success?.should be_true
  end

  it 'should set success flag to false when a command fails' do
    @mock_cmd_line.stub!(:execute).with("cd #{@project.path} && #{COMMANDS[0]}").and_return(false)
    Build.run!(@project)
    Build.last.success?.should be_false
  end

  it 'should use created_at for started_at' do
    build = Build.new
    build.stub!(:created_at).and_return('creation ')
    build.started_at.should == build.created_at
  end
end
