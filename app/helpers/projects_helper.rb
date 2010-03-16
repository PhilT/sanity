module ProjectsHelper
  def build_class(build)
    return 'build_notrun' if build.nil?
    if build.completed_at.nil?
      'build_running'
    elsif build.success?
      'build_successful'
    else
      'build_failed'
    end
  end

  def status(build)
    {'build_running' => 'running', 'build_successful' => 'built successfully', 'build_failed' => 'failed'}[build_class(build)]
  end

  def last_build_status(build)
    return 'Build never run' if build.nil?
    status = {'build_running' => 'Build started', 'build_successful' => 'Last build ran successfully', 'build_failed' => 'Last build failed'}[build_class(build)]
    "#{status} #{time_ago_in_words(build.created_at)} ago"
  end
end

