Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # Default route
  # get ':controller(/:action(/:id))'



  resources :tasklists do
    resources :tasks do
        member do 
          patch :complete # references the complete method we defined in the tasks controller.  
        end
    end
  end


  
  root 'tasklists#index'

  devise_scope :user do 
    get '/users/sign_out' => 'devise/sessions#destroy' 
  end

end
