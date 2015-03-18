Ageism::Application.routes.draw do
  get "dataaccess" => "dataaccess#index"

  get "payout" => "payout#index"

  get "final"   => "final#index"

  get "results"  => "results#index"

  get "results2" => "results#results2"

  get "debug" => "debug#index"

  get "guess" => "guess#index"

  get "failedlogin" => "failedlogin#index"

  get "control" => "control#index"

  get "controllogin" => "controllogin#index"

  get "participant" => 'participant#index'

  get "wait" => 'wait#index'

  get "login" => 'login#index'

  match "control/pageupdate"  => "control#pageupdate"

  match "payout/pageupdate" => "payout#pageupdate"
  match "payout/savename" => "payout#savename"
  match "wait/pageupdate" => "wait#pageupdate"
  match "guess/pageupdate" => "guess#pageupdate"
  match "participant/pageupdate" => "participant#pageupdate"
  match "final/pageupdate" => "final#pageupdate"
  match "results/pageupdate" => "results#pageupdate"
  match "results/loadhistorydata" => "results#loadhistorydata"
  match "results/done" => "results#done"
  match "final/loadhistorydata" => "final#loadhistorydata"
  match "final/guesspayment" => "final#guesspayment"
  match "final/interactpayment" => "final#interactpayment"

  match "login/validatelogin"
  match "controllogin/validatecontroller"
  match "control/startexperiment"
  match "control/resetexperiment"
  match "control/closeresults"
  match "control/changeamount"
  match "control/changerequiredusers"
  match "control/changeautoplay"
  match "control/changeallowlogins"
  match "control/changerequirepasswords"
  match "results2" => "results#results2"
  match "final2" => "final#final2"
  
  get "validatelogin" => 'login#validatelogin'
  get "validatecontroller" => 'controllogin#validatecontroller'
  match "guess/submitguess"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
  root :to => 'login#index'
  #match "", to: redirect("/login")
  #match ':controller(/:action(/:id))'

end
