ActionController::Routing::Routes.draw do |map|
  map.resources :projects, :except => [:show] do |project|
    project.resources :builds
  end

  map.root :controller => :projects
end

