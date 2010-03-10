ActionController::Routing::Routes.draw do |map|
  map.resources :projects do |project|
    project.resources :builds
  end
end

