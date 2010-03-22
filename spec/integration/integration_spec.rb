require 'spec/spec_helper'

describe 'Sanity' do
  before(:all) do
    @build_path = File.join(RAILS_ROOT, 'tmp', 'integration')
    FileUtils.rm_rf @build_path
    Project.destroy_all
    Build.destroy_all

    @project1 = 'project'
    @project2 = 'another_project'
    create_git_repo(@project1)
    create_git_repo(@project2)
  end

  it 'should create projects and run builds as they are checked in' do
    visit root_url
    create_projects
    indicate_build_has_run

  end

  def indicate_build_has_run
    commit_code_to @project1
    run_build_runner
    visit root_url
    response.body.should contain 'Last build ran successfully less than a minute ago'
  end

  def run_build_runner
    Project.all.each {|project|project.check}
  end

  def commit_code_to(name)
    name = File.join(@build_path, 'repos', name)
    `cd #{name} && touch new_file && git add . && git ci -m 'initial commit'`
  end

  def create_projects
    create_project @project1, "echo ........F.........."
    create_project @project2, "echo ........F.........."

    response.body.should contain @project1
    response.body.should contain @project2
    response.body.should contain 'Build never run'
    response.body.should contain File.join(@build_path, 'repos', @project2)
  end

  def create_git_repo(name)
    name = File.join(@build_path, 'repos', name)
    `mkdir -p #{name} && cd #{name} && git init`
  end

  def create_project(name, commands)
    working_dir = File.join(@build_path, 'working', name)
    clone_from = File.join(@build_path, 'repos', name)
    name = name.titleize
    click_link 'new'
    fill_in 'Name:', :with => name
    fill_in 'Working directory:', :with => working_dir
    fill_in 'Clone from:', :with => clone_from
    fill_in 'Commands:', :with => commands
    click_button 'Save'
  end
end

