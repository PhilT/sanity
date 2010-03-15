module ProjectsHelper
  def build_class(build)
    build.try(:success?) ? 'build_successful' : 'build_failed'
  end

  def last_build_status(build)
    status = build.try(:success?) ? 'successfully' : 'with errors'
    build.nil? ? "not built yet" : "Last build ran #{status} #{time_ago_in_words(build.created_at)} ago"
  end
end

