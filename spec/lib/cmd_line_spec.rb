require 'spec_helper'

describe CmdLine do
  it 'should collect the output of the command' do
    cmd = CmdLine.new
    cmd.execute('echo TESTING CmdLine class').should be_true
    cmd.success?.should be_true
    cmd.output.should == "TESTING CmdLine class\n"
  end

  it 'should return false when command fails' do
    cmd = CmdLine.new
    cmd.execute('unkown_command').should be_false
    cmd.success?.should be_false
    cmd.output.should == "sh: unkown_command: not found\n"
  end
end

