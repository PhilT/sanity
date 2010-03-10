module ProjectsHelper
  def last_build_status(project)
    build = project.builds.last
    build.nil? ? "not built yet" : "Last build ran #{time_ago_in_words(build.created_at)} #{build.success? ? 'successfully' : 'with errors'}"
  end
end

