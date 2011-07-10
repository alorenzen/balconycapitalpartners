Enki::Application.routes.draw do
  match '/about', :to => 'main_pages#about'
  match '/blog', :to => 'posts#index'
  match 'auth/:provider/callback', :to => 'admin/sessions#create'
  match 'auth/failure' => redirect("/")

  get "main_pages/home"

  get "main_pages/about"

  namespace 'admin' do
    resource :session, :except => [:new, :create]

    resources :posts, :pages do
      post 'preview', :on => :collection
    end
    resources :comments
    resources :undo_items do
      post 'undo', :on => :member
    end

    match 'health(/:action)' => 'health', :action => 'index', :as => :health

    root :to => 'dashboard#show'
  end

  resources :archives, :only => [:index]
  resources :pages, :only => [:show]

  constraints :year => /\d{4}/, :month => /\d{2}/, :day => /\d{2}/ do
    post ':year/:month/:day/:slug/comments' => 'comments#index'
    get ':year/:month/:day/:slug/comments/new' => 'comments#new'
    get ':year/:month/:day/:slug' => 'posts#show'
  end

  root :to => 'main_pages#home'

  scope :to => 'posts#index' do
    get 'posts.:format', :as => :formatted_posts
    get '(:tag)', :as => :posts
  end


end
