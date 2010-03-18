require 'spec_helper'

describe ProjectsHelper do
  describe 'build_class' do
    it do
      helper.build_class(nil).should == 'build_notrun'
    end
  end
end

