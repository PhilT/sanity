require 'spec_helper'

describe CmdLine do
  it 'should collect the output of the command' do
    cmd = CmdLine.new
    cmd.execute('echo TESTING CmdLine class', nil).should be_true
    cmd.success?.should be_true
    cmd.output.should == "TESTING CmdLine class\n"
  end

  it 'should return false when command fails' do
    cmd = CmdLine.new
    cmd.execute('unknown_command', nil).should be_false
    cmd.success?.should be_false
  end

  it 'should return retreive errors' do
    cmd = CmdLine.new
    cmd.execute('unknown_command', nil)
    cmd.output.should == "sh: unknown_command: not found\n"
  end

  it 'should switch to specified working directory' do
    cmd = CmdLine.new
    cmd.execute('pwd', '/tmp')
    cmd.output.should == "/tmp\n"
  end
end

