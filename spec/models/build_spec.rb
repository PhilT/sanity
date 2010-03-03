require 'spec_helper'

describe Build do
  before(:each) do
    @mock_cmd_line = mock(CmdLine)
    CmdLine.stub!(:new).and_return @mock_cmd_line
    @git_log_stat = IO.readlines('spec/fixtures/git_log_numstat.txt','').to_s
    @mock_cmd_line.stub!(:execute).with('git log --numstat ').and_return(@git_log_stat)

  end

  it 'should parse git log --stat messages' do
    Build.run!(Factory(:project))
    build = Build.last
    build.commit_hash.should == '6c59a90cb8a31442276e808ca745a35311d244bf'
    build.author.should == 'A Developer <phil@example.com>'
    build.committed_at.should == DateTime.new(2010, 2, 3, 4, 59, 49)
    build.commit_message.should == "This is the commit message. It can be as long as you like\nand have new lines. It's indented to show where it finishes."
    build.changed_files.should == 'db/migrate/20100203025923_create_projects.rb,db/schema.rb,db/seeds.rb,lib/build.rb,script/build_runner'
  end

  it 'should check for commits from the last one in the builds table' do
    commit_hash = 'some commit hash'
    previous_build = Factory(:build, :commit_hash => commit_hash)
    @mock_cmd_line.should_receive(:execute).with("git log --numstat #{commit_hash}..HEAD").and_return(@git_log_stat)
    Build.new
  end

  it 'should create a new build for each new commit' do
    proc { Build.run! }.should change(Build, :count).by(2)
  end

  it 'should have a completed date when complete' do
    build = Build.new
    proc { build.run }.should change(build, :completed_at).from(nil).to(DateTime.now)
  end

  it 'should use created_at for started_at' do
    build = Build.new
    build.stub!(:created_at).and_return('creation ')
    build.started_at.should == build.created_at
  end
end

