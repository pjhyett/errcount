ActionController::Routing::Routes.draw do |map|
  map.resources :sites
  map.connect "", :controller => "sites", :action => "new"
end
